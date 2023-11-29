scr_wws_packet_database_ini();

if (scr_launch_param("quickhost")) scr_wws_create_server("Host", false);
if (scr_launch_param("quickcon")) scr_wws_join_server("127.0.0.1", "Client", false);