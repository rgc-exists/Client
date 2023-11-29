// TODO: Move to a menu option maybe?
if (keyboard_check_pressed(vk_ralt))
{
    var steam = show_question("Steam?");
    var name = get_string("Name", "Player");

    if (show_question("Host?"))
    {
        scr_wws_create_server(name, steam);    
    }
    else
    {
        if (steam)
        {
            show_message("You cant join while using steam accept an invite instead!");
            return;
        }

        var ip = get_string("Ip", "127.0.0.1");

        scr_wws_join_server(ip, name, false);
    }
}