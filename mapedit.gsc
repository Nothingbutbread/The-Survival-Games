init_MapEdit()
{
	if(getDvar("mapname") == "mp_nuketown_2020")
		level thread Nuketown();
	if(getDvar("mapname") == "mp_hijacked")
		level thread Hijacked();
	if(getDvar("mapname") == "mp_express")
		level thread Express();
	if(getDvar("mapname") == "mp_meltdown")
		level thread Meltdown();
	if(getDvar("mapname") == "mp_drone")
		level thread Drone();
	if(getDvar("mapname") == "mp_carrier")
		level thread Carrier();
	if(getDvar("mapname") == "mp_overflow")
		level thread Overflow();
	if(getDvar("mapname") == "mp_slums")
		level thread Slums();
	if(getDvar("mapname") == "mp_turbine")
		level thread Turbine();
	if(getDvar("mapname") == "mp_raid")
		level thread Raid();
	if(getDvar("mapname") == "mp_la")
		level thread Aftermath();	
	if(getDvar("mapname") == "mp_dockside") 
		level thread Cargo();	
	if(getDvar("mapname") == "mp_village")
		level thread Standoff();
	if(getDvar("mapname") == "mp_nightclub")
		level thread Plaza();	
	if(getDvar("mapname") == "mp_socotra")
		level thread Yemen();
	if(getDvar("mapname") == "mp_dig")
		level thread Dig();	
	if(getDvar("mapname") == "mp_pod")
		level thread Pod();	
	if(getDvar("mapname") == "mp_takeoff")
		level thread Takeoff();	
	if(getDvar("mapname") == "mp_frostbite")
		level thread Frost();	
	if(getDvar("mapname") == "mp_mirage")
		level thread Mirage();	
	if(getDvar("mapname") == "mp_hydro")
		level thread Hydro();	
	if(getDvar("mapname") == "mp_skate")
		level thread Grind();	
	if(getDvar("mapname") == "mp_downhill")
		level thread Downhill();	
	if(getDvar("mapname") == "mp_concert")
		level thread Encore();	
	if(getDvar("mapname") == "mp_vertigo")
		level thread Vertigo();	
	if (getDvar("mapname") == "mp_magma")
		level thread Magma();
	if(getDvar("mapname") == "mp_studio")
		level thread Studio();	
	if(getDvar("mapname") == "mp_paintball")
		level thread Rush();	
	if(getDvar("mapname") == "mp_castaway")
		level thread Cove();	
	if(getDvar("mapname") == "mp_bridge")
		level thread Detour();
	if(getDvar("mapname") == "mp_uplink")
		level thread Uplink();
}

Nuketown()
{ 
	level thread DeleteDeathBarriers();
	// East side out of map blockers
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (90,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (602,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1114,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1370,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-422,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-934,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1190,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1273,-1043,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1513,-535,-60), (0,135,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1650,-221,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1231,-540, 275), (0,135,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-980,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-570,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-250,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1250,-980,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1250,-703,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (980,-1053,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_256x256x10", (739,-631,-60), (0,90,0));
	level thread Forge_Teleport((1463,25,-63),(1429,-1092,-60));
	level thread Forge_Teleport((-1631,108,-64),(-1622,-12,-64));
	level thread Forge_Teleport((-226,-334,-60),(-241,-743,-60));
	// West side out of map blockers
	level thread Forge_Teleport((-1229,993,-63),(-1151,1169,-60));
	level thread Forge_Teleport((1330,1066,-63),(1263,1209,-60));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (150,1765,-60), (0,0,90));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-390,1686,-60), (0,0,90));
	
	level.finalspawnpoint = (108,344,-37);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -100;
	
	ACL((534,1160,-62));
	ACL((374,1570,-54));
	ACL((-361,1595,-54));
	ACL((-445,1114,-62));
	ACL((-1509,1643,-62));
	ACL((1348,1750,-62));
	
	ACL((1597,1074,-55));
	ACL((1917,678,-64));
	ACL((1574,26,-62));
	ACL((807,6,-62));
	ACL((940,115,-56));
	ACL((871,453,-56));
	ACL((729,47,80));
	ACL((1107,475,80));
	ACL((494,296,90));
	ACL((682,723,-54));
	
	ACL((-39,1105,-47));
	ACL((33,426,-16));
	ACL((-44,-284,-67));
	ACL((-557,824,-63));
	ACL((-1771,841,-63));
	ACL((-1918,678,-64));
	ACL((-1932,158,-61));
	ACL((-1390,70,-48));
	ACL((-832,15,-56));
	ACL((-727,526,-56));
	ACL((-698,548,80));
	ACL((-171,562,73));
	ACL((1270,-1204,-63));
	ACL((1573,-81,-64));
	ACL((477,-415,-61));
	ACL((959,-858,-64));
	ACL((180,-1204,-65));
	ACL((-7,-844,-66));
	ACL((-446,-552,-60));
	ACL((-1314,-717,-62));
}

Hijacked()
{ }

Express()
{ }

Meltdown()
{ }

Drone()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-655,-706,-24);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -3000;
	ACL((-1212,-2464,65));
	ACL((-15,-1483,5));
	ACL((507,-386,20));
	ACL((834,-880,240));
	ACL((17,-685,240));
	ACL((-808,-1657,164));
	ACL((-1071,-687,265));
	ACL((-1922,-443,96));
	ACL((-890,-208,98));
	ACL((-1098,772,96));
	ACL((-1030,968,264));
	ACL((144,1214,267));
	ACL((817,1051,264));
	ACL((818,1065,124));
	ACL((1408,1862,60));
	ACL((100,1827,141));
	ACL((-531,3021,346));
	ACL((1266,2922,320));
	ACL((-1022,1336,136));
	ACL((-536,2441,307));
	ACL((659,1906,210));
	ACL((1112,3782,311));
	level thread Forge_Teleport((968,3684,299), (985,4017,303));
	level thread Forge_Teleport((-2006,-1949,80), (-2013,-2268,80));
	//Outside of map
	level thread BlackListedZone((-4253,-2073,500),(-2790,-1000,-9999)); // Patches a fallout area
	ACL((978,5133,660));
	ACL((-1323,3269,441));
	ACL((-8182,2150,80));
	ACL((-4282,1117,80));
	ACL((-6040,-1664,120));
	ACL((-9527,350,45));
	ACL((-13512,4581,1017));
	ACL((-2384,-2793,75));
	ACL((-3243,-3873,82));
	ACL((-7383,-4130,145));
	ACL((-9477,-6515,195));
	ACL((-12751,-7853,88));
	ACL((-15757,-6432,285));
	ACL((-15892,-9221,912));
	ACL((-10619,-10132,630));
	ACL((-9465,-13279,902));
	ACL((-6518,-12663,784));
	ACL((-3957,-14254,551));
	ACL((-3691,-11076,374));
	ACL((-5338,-8893,790));
	ACL((-6072,-6863,706));
	ACL((-3081,-6372,348));
	ACL((-761,-6885,401));
	ACL((2731,-10466,256));
	ACL((1688,-7252,35));
	ACL((180,-4687,121));
	ACL((560,-3083,82));
	ACL((1313,-1767,94));
	ACL((2624,-3586,603));
	ACL((4646,-9100,28));
}

Carrier()
{ }

Overflow()
{ }

Slums()
{ }

Turbine()
{ }

Raid() 
{ }

Aftermath()
{ }

Cargo()
{ }

Standoff()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-442,-500,10);
	level.deadmansskybarrier = 4300;
	level.belowmapdeathbarrier = -3000;
	ACL((489,-188,16));
	ACL((69,-513,16));
	ACL((-361,414,12));
	ACL((249,-538,155));
	ACL((-595,-1307,40));
	ACL((577,-1144,5));
	ACL((1195,-1006,10));
	ACL((1656,403,10));
	ACL((995,1067,10));
	ACL((724,2001,10));
	ACL((188,1362,10));
	ACL((149,928,150));
	ACL((-1346,644,10));
	ACL((-1578,-326,10));
	ACL((-1810,-1700,10));
	ACL((-866,-1306,10));
	ACL((-442,-247,10));
	ACL((-1313,1615,10));
	ACL((-1041,3782,5));
	ACL((1977,4285,5));
	ACL((1994,1603,5));
	ACL((1233,1645,10));
	ACL((1818,898,90));
	ACL((1791,-1215,10));
	// (594,-1615,-191, -5)
	Forge_Spawn_Object("collision_clip_wall_256x256x10", (594,-1615, -5), (0,0,90)); // Patches an exploitable hole in the map.
	ACL((729,-1796,10));
	ACL((-775,-2062,10));
	ACL((-2036,-1512,10));
	ACL((-1987,430,10));
	ACL((-4493,1215,10));
	ACL((-4860,2813,-45));
	ACL((-4805,4726,30));
	ACL((-7384,5239,1025));
	ACL((-9802,8688,585));
	ACL((-11917,12524,1762));
	ACL((-10576,16536,4248));
	ACL((-6860,15923,2195));
	ACL((-849,11350,1615));
	ACL((2390,10880,45));
	ACL((8683,12526,305));
	ACL((8477,17431,2695));
	ACL((9540,10507,295));
	ACL((16234,5538,25));
	ACL((413,-4508,10));
	ACL((7647,2239,45));
	ACL((6709,4835,80));
	level thread Forge_Teleport((-1584,-2376,0), (-1676,-2647,0));
	level thread Forge_Teleport((-1137,867,0), (-1488,888,0));
	level thread Forge_Teleport((817,1976,10), (803,2205,3));
	level thread Forge_Teleport((1537,-316,0), (1916,-357,42));
}

Plaza()
{ }

Yemen()
{ }

Dig()
{ }

Pod()
{ }

Takeoff()
{ }

Frost()
{ }

Mirage()
{ }

Hydro()
{ }

Grind()
{ }

Downhill()
{ }

Encore()
{ }

Vertigo()
{ }

Magma()
{ }

Studio()
{ }

Rush()
{ }

Cove()
{ }

Detour()
{ }

Uplink()
{ }




