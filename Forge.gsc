Forge_Spawn_Object(model, origin, angle)
{
	obj = spawnEntity(model, origin, angle);
}
spawnEntity(model, origin, angle)
{
	if (!isdefined(angle)) { angle = (0,0,0); }
    entity = spawn("script_model", origin);
    entity.angles = angle;
    entity setModel(model);
    return entity;
}
ACL(origin)  { level.lc[level.lc.size] = origin; } // Add Create Location
Spawn_LootCrate(index, location) // Generic loot crate. Contents generated are players based on thier varribles.
{
	level endon("game_ended");
	// Checks complete, we are go for spawning a crate here.
	if (LootCreateDupeCheck(index, location))
	{
		level.activelootboxes++;
		level.lca[index] = location; // Set
		killloop = false;
		obj = spawnEntity("t6_wpn_supply_drop_trap", level.lc[location], (0,0,90));
		//iprintln("Loot Crate " + index + " spawned at " + location);
		marker = CreateWaypoint("perk_hardline", level.lc[location] + (0,0,50) , 5, 5, .7, true);
		while(true)
		{
			foreach(player in level.players)
			{
				if (Distance(player.origin, level.lc[location]) < 50)
				{
					if (player meleebuttonpressed() && !player.inventory_menu_open && !player.loot_menu_open && player.canusemenu)
					{
						player thread giveSupplyDrop();
						killloop = true;
						break;
					}
					if (player meleebuttonpressed() && !player.canusemenu)
					{
						player iprintln("^1Can't open loot box while under a proxy attack!");
					}
				}
			}
			if (killloop) { break; }
			wait .1;
		}
		//
		marker Destroy();
		obj delete();
		level.lca[index] = -1; // Create is now longer active.
		level.activelootboxes--;
	}
}
Forge_Teleport(start, end)
{
	level endon("game_ended");
	obj = spawnEntity("mp_flag_neutral", start, (0,0,0));
	SpawnIcon(start, "waypoint_recon_artillery_strike");
	obj2 = spawnEntity("mp_flag_neutral", end, (0,0,0));
	SpawnIcon(end, "waypoint_recon_artillery_strike");
	while(1)
    {
	    foreach(player in level.players)
	    {
	    	if (Distance(player.origin, start) < 20 && player.canteleport)
	    		player thread SetOrigin_fixed(end);
	    	else if (Distance(player.origin, end) < 20 && player.canteleport)
	    		player thread SetOrigin_fixed(start);
	   	}
	   	wait .1;
	}
}
SetOrigin_fixed(origin)
{
	self.canteleport = false;
	self setorigin(origin);
	wait 1;
	self.canteleport = true;
}

BlackListedZone(cor1,cor2)
{
	if (cor1[0] > cor2[0])
	{
		low0 = cor2[0];
		high0 = cor1[0];
	}
	else
	{
		high0 = cor2[0];
		low0 = cor1[0];
	}
	
	if (cor1[1] > cor2[1])
	{
		low1 = cor2[1];
		high1 = cor1[1];
	}
	else
	{
		high1 = cor2[1];
		low1 = cor1[1];
	}
	
	if (cor1[2] > cor2[2])
	{
		low2 = cor2[2];
		high2 = cor1[2];
	}
	else
	{
		high2 = cor2[2];
		low2 = cor1[2];
	}
	while(true)
    {
    	wait .1;
	    foreach(player in level.players)
	    {
			if (player.origin[0] >= low0 && player.origin[0] <= high0)
			{
				if (player.origin[1] >= low1 && player.origin[1] <= high1)
				{
					if (player.origin[2] >= low2 && player.origin[2] <= high2)
					{
						if (player.savedfromthedepths)
						{
							player iprintln("^1You've walked into a blacklisted zone.\nNext time you will die instead!");
							player.savedfromthedepths = false;
							n = RandomIntRange(0,8);
							player setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
						}
						else { player suicide(); }
					}
				}
			}
		}
	}
}


