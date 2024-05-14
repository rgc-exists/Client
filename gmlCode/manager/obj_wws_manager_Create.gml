scr_wws_packet_database_ini();
scr_wws_objSync_database_ini();
in_chat = false;
currentMessage = ""
maxchatlength = 55
messages = []
chatHistoryLength = 23
chatDisplayCount = 15

if (scr_launch_param("quickhost")) scr_wws_create_server("Host", false);
if (scr_launch_param("quickcon")) scr_wws_join_server("127.0.0.1", "Client", false);

