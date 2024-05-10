if (!variable_instance_exists(id, "dir"))
    return false;
    
if (variable_instance_exists(id, "custom_player"))
{
	if (custom_player.dead >= 0)
	{
		return false;
	}
}

#orig#();