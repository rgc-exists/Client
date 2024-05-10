using System.Reflection;
using System.Text.Json;
using System.Text.RegularExpressions;
using GMHooker;
using UndertaleModLib;
using UndertaleModLib.Models;
using GMSL;
using UndertaleModLib.Decompiler;

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
        data.FinalizeHooks();

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
            Persistent = true,
            CollisionShape = CollisionShapeFlags.Box,
            Sprite = data.Sprites.ByName("spr_player_base")
        });
        data.GameObjects.Add(new()
        {
            Name = data.Strings.MakeString("obj_wws_projectile"),
            Persistent = false,
            CollisionShape = CollisionShapeFlags.Box,
            Sprite = data.Sprites.ByName("spr_back_square")
        });
        data.GameObjects.Add(new()
        {
            Name = data.Strings.MakeString("obj_wws_aim_target"),
            Persistent = false,
            Sprite = data.Sprites.ByName("spr_mine_warning")
        });
    }

    private void LoadAllCode()
    {
        ExtraCodeSetup_Early();

        var code = File.ReadAllText(Path.Combine(BaseDirectory, "directories.json"));
        Dictionary<string, string> directories = JsonSerializer.Deserialize<Dictionary<string, string>>(code) ?? new();

        foreach (var directory in directories)
        {
            LoadDirectory(directory);
        }

        ExtraCodeSetup_Late();
    }

    private void ExtraCodeSetup_Early(){
        UndertaleCode scr_update_power_grid = data.Code.ByName("gml_GlobalScript_scr_update_power_grid");
        GlobalDecompileContext globalDecompileContext = new GlobalDecompileContext(data, false);
        string powerGridUpdate_decompiled = Decompiler.Decompile(scr_update_power_grid, globalDecompileContext);
        powerGridUpdate_decompiled = powerGridUpdate_decompiled.Replace("ds_list_destroy(li_powered)", "");
        scr_update_power_grid.ReplaceGmlSafe(powerGridUpdate_decompiled, data);
    }
    
    private void ExtraCodeSetup_Late(){

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
            else if(type == EventType.Collision) subtype = (uint) data.GameObjects.IndexOf(data.GameObjects.ByName(objCode.subtype));
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
