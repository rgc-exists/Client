﻿using System.Reflection;
using System.Text.Json;
using System.Text.RegularExpressions;
using GMHooker;
using UndertaleModLib;
using UndertaleModLib.Models;
using GMSL;

namespace WillWeSnail;

public class WillWeSnail : IGMSLMod
{
    private Dictionary<string, Action<string, string>> FileHandlers = new();
    private static string BaseDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
    private static UndertaleData data;
    
    public void Load(UndertaleData d, ModInfo modInfo)
    {
        data = d;
 
        if (!File.Exists(Path.Combine(BaseDirectory, "directories.json")))
        {
            Console.WriteLine("Cant find directories.json inside the path " + BaseDirectory);
        }

        SetupFileHandlers();
        AddObjects();
        LoadAllCode();

        // TODO: Load plugins / mods to add custom packets
    }

    private void AddObjects()
    {
        data.GameObjects.Add(new()
        {
            Name = data.Strings.MakeString("obj_wws_manager"),
            Persistent = true
        });
        data.GameObjects.Add(new()
        {
            Name = data.Strings.MakeString("obj_wws_player"),
            Persistent = true
        });
    }

    private void LoadAllCode()
    {
        var code = File.ReadAllText(Path.Combine(BaseDirectory, "directories.json"));
        Dictionary<string, string> directories = JsonSerializer.Deserialize<Dictionary<string, string>>(code) ?? new();

        foreach (var directory in directories)
        {
            LoadDirectory(directory);
        }
    }
    
    private void LoadDirectory(KeyValuePair<string, string> directory)
    {
        foreach (var file in Directory.GetFiles(Path.Combine(BaseDirectory, directory.Key))) {
            Console.WriteLine($"Loading: {Path.GetFileNameWithoutExtension(file)} with {directory.Value}");
            FileHandlers[directory.Value].Invoke(File.ReadAllText(file), file);
        }    
    }

    private void SetupFileHandlers()
    {
        Action<string, string> loadFunction = (code, file) =>
        {
            MatchCollection matchList = Regex.Matches(code, @"(?<=argument)(\d*)");
            ushort argCount;
            if (matchList.Count > 0)
                argCount = (ushort)(matchList.Cast<Match>().Select(match => ushort.Parse(match.Value)).ToList().Max() + 1);
            else
                argCount = 0;

            data.CreateLegacyScript(Path.GetFileNameWithoutExtension(file), code, argCount);
        };
        FileHandlers.Add("functions", loadFunction);
        
        Action<string, string> loadObjectCode = (code, file) =>
        {
            if(!file.EndsWith(".json")) {
                return;
            }

            ObjectFile? objCode = JsonSerializer.Deserialize<ObjectFile>(code);

            if (objCode == null)
            {
                Console.WriteLine(file + " is null, skipping...");
                return;
            }

            EventType type = (EventType)Enum.Parse(typeof(EventType), objCode.type);
            uint subtype;

            if (!objCode.hasSubtype) subtype = uint.Parse(objCode.subtype);
            else subtype = (uint)Enum.Parse(FindType("UndertaleModLib.Models.EventSubtype" + objCode.type), objCode.subtype);
            
            data.GameObjects.ByName(objCode.name)
                .EventHandlerFor(type, subtype, data.Strings, data.Code, data.CodeLocals)
                .ReplaceGmlSafe(File.ReadAllText(Path.Combine(Path.GetDirectoryName(file), objCode.file)), data);
        };
        FileHandlers.Add("object_code", loadObjectCode);
        
        Action<string, string> loadCodeHook = (code, file) =>
        {
            data.HookCode(Path.GetFileNameWithoutExtension(file), code);
        };
        FileHandlers.Add("code_hooks", loadCodeHook);

        Action<string, string> loadFunctionHook = (code, file) =>
        {
            data.HookFunction(Path.GetFileNameWithoutExtension(file), code);
        };
        FileHandlers.Add("function_hooks", loadFunctionHook);
    }
    
    private static Type? FindType(string qualifiedTypeName)
    {
        Type? t = Type.GetType(qualifiedTypeName);

        if (t != null)
        {
            return t;
        }
        else
        {
            foreach (Assembly asm in AppDomain.CurrentDomain.GetAssemblies())
            {
                t = asm.GetType(qualifiedTypeName);
                if (t != null)
                    return t;
            }
            return null;
        }
    }
}
