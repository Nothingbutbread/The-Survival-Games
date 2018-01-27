#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
	PrecacheItem("minigun_wager_mp");
	PrecacheItem("m32_wager_mp");
	Precacheshader("perk_hardline");
	Precacheshader("perk_awareness");
	PrecacheModel("projectile_sidewinder_missile");
	PrecacheModel("mp_flag_neutral");
	PrecacheModel("t6_wpn_supply_drop_trap");
	PrecacheModel("collision_clip_wall_128x128x10");
	PrecacheModel("collision_clip_wall_256x256x10");
	PrecacheModel("collision_clip_wall_512x512x10");
	level.strings = [];
	level.lc = []; // Loot crate possible locations, Storeage of vectors.
	level.overflowfixthreaded = false;
	level.finalspawnpoint = (0,0,0);
	level.startalive = true;
	level.peacetime = false;
	level.belowmapdeathbarrier = -3000;
	level.activetraps = 0;
	level.targtedplayers = 0;
	level.activelootboxes = 0;
	level.mmiconsspawned = 0;
	level.debugger = false;
	level DefineWeapondataarray();
    level thread onPlayerConnect();
    level thread init_SurvivalGames();
    if (!level.debugger) { registernumlives(1, 100); }
    registertimelimit( 0, 0);
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if (!level.overflowfixthreaded) { level thread overflowfix(); level.overflowfixthreaded = true; level.lastkilled = player; }
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	self.inventory_menu_open = false;
	self.loot_menu_open = false;
	self.iscoolfordisgame = false;
	self.occupation = "";
	self.occupation_bonus = false;
	self.canteleport = true;
	self.cantaunt = true;
	self.istargted = false;
	self.curspeed = 1;
	self.basespeed = 1;
	self.basehealth = 100;
	self.resistanceabilityactive = false;
	self.canusemenu = true;
	self.savedfromthedepths = true;
	self.lootboxrarity = "Common";
	self.lootboxitemcount = 0;
	self.spawnorigin = (0,0,0);
	self thread init_HUDS();
	self thread onPlayerDisconnect();
	if (self isHost()) { self thread AntiEndgame(); level.dahost = self; }
    while(true)
    {
    	self notify("menuresponse", "changeclass", "class_smg");
        self waittill("spawned_player");
        self.spawnorigin = self.origin;
        self SetClientUIVisibilityFlag("g_compassShowEnemies", 0);
        if (level.debugger) { self thread getOrigin(); }
        self StartingLoadout();
        self FreezeControls(false);
        self.iscoolfordisgame = level.startalive;
        self.inventory_menu_open = false;
        self.loot_menu_open = false;
        self.canusemenu = true;
        self.resistanceabilityactive = false;
        self thread Menu_Inventory_Open_Bind(); // If the player is not in, the bind will not run.
        self.inventory_menu_HUD.alpha = 0;
		self.inventory_menu_BG.alpha = 0;
		self.inventory_menu_Scroller.alpha = 0;
		self.loot_menu_Scroller.alpha = 0;
		self EnableInvulnerability();
		self thread onPlayerDeath();
        if (self.iscoolfordisgame) // Player is in the game
        {
        	self thread WatchForFallOutOfMap();
        }
    }
}

DefineWeapondataarray()
{
	level.AttachmentArray = [];
	level.AttachmentArray[0] = "dualoptic"; //Hybrid Optic
	level.AttachmentArray[1] = "extbarrel"; //Long Barrel
	level.AttachmentArray[2] = "fastads"; //Quickdraw
	level.AttachmentArray[3] = "grip"; //Fore Grip
	level.AttachmentArray[4] = "holo"; //EOTech
	level.AttachmentArray[5] = "mms"; //MMS
	level.AttachmentArray[6] = "rangefinder"; //Target Finder
	level.AttachmentArray[7] = "reflex"; //Reflex Sight
	level.AttachmentArray[8] = "rf"; //Rapid Fire
	level.AttachmentArray[9] = "tacknife"; //Tactical Knife
	level.AttachmentArray[10] = "stalker"; //Stock
	level.AttachmentArray[11] = "silencer"; //Suppressor
	level.AttachmentArray[12] = "extclip"; //Extended Clip
	level.AttachmentArray[13] = "fmj"; //FMJ
	level.AttachmentArray[14] = "steadyaim"; //Laser
	level.AttachmentArray[15] = "acog"; //ACOG
	level.AttachmentArray[16] = "dualclip"; //Fast Mag
	level.AttachmentArray[17] = "vzoom"; //Variable Zoom
	level.AttachmentArray[18] = "ir"; //Dual Band
	level.AttachmentArray[19] = "is"; //?
	level.AttachmentArray[20] = "swayreduc"; //Ballistics CPU
	level.AttachmentArray[21] = "stackfire"; //Tri-Bolt
	//level.AttachmentArray[11] = "sf"; //Select Fire
	//level.AttachmentArray[4] = "gl"; //Grenade Launcher
	level.WeaponArray2 = [];
	level.WeaponArray2[0] = "frag_grenade_mp";
	level.WeaponArray2[1] = "sticky_grenade_mp";
	level.WeaponArray2[2] = "hatchet_mp";
	level.WeaponArray2[3] = "bouncingbetty_mp";
	level.WeaponArray2[4] = "satchet_charge_mp";
	level.WeaponArray2[5] = "claymore_mp";
	
	level.WeaponArray3 = [];
	level.WeaponArray3[0] = "concussion_grenade_mp";
	level.WeaponArray3[1] = "willy_pete_mp";
	level.WeaponArray3[2] = "sensor_grenade_mp";
	level.WeaponArray3[3] = "emp_grenade_mp";
	level.WeaponArray3[4] = "proximity_grenade_mp";
	level.WeaponArray3[5] = "pda_hack_mp";
	level.WeaponArray3[6] = "flash_grenade_mp";
	level.WeaponArray3[7] = "trophy_system_mp";
	level.WeaponArray3[8] = "tactical_insertion_mp";
	
	level.WeaponArray = [];
	
	level.WeaponArray[0] = "smaw_mp";
	level.WeaponArray[1] = "usrpg_mp";
	level.WeaponArray[2] = "crossbow_mp";
	level.WeaponArray[3] = "knife_ballistic_mp";
	level.WeaponArray[4] = "riotshield_mp";
	
	level.WeaponArray[5] = "fiveseven_dw_mp";
	level.WeaponArray[6] = "fnp45_dw_mp";
	level.WeaponArray[7] = "beretta93r_dw_mp";
	level.WeaponArray[8] = "judge_dw_mp";
	level.WeaponArray[9] = "kard_dw_mp";
	level.WeaponArray[10] = "kard_mp";	
	level.WeaponArray[11] = "fnp45_mp";
	level.WeaponArray[12] = "beretta93r_mp";
	level.WeaponArray[13] = "judge_mp";
	level.WeaponArray[14] = "fiveseven_mp";
	
	level.WeaponArray[15] = "870mcs_mp";
	level.WeaponArray[16] = "saiga12_mp";
	level.WeaponArray[17] = "ksg_mp";
	level.WeaponArray[18] = "srm1216_mp";
	
	
	level.WeaponArray[19] = "mp7_mp";
	level.WeaponArray[20] = "pdw57_mp";
	level.WeaponArray[21] = "vector_mp";
	level.WeaponArray[22] = "insas_mp";
	level.WeaponArray[23] = "qcw05_mp";
	level.WeaponArray[24] = "evoskorpion_mp";
	level.WeaponArray[25] = "peacekeeper_mp";
	
	level.WeaponArray[26] = "tar21_mp";
	level.WeaponArray[27] = "type95_mp";
	level.WeaponArray[28] = "sig556_mp";
	level.WeaponArray[29] = "sa58_mp";
	level.WeaponArray[30] = "hk416_mp";
	level.WeaponArray[31] = "scar_mp";
	level.WeaponArray[32] = "saritch_mp";
	level.WeaponArray[33] = "xm8_mp";
	level.WeaponArray[34] = "an94_mp";
	
	level.WeaponArray[35] = "mk48_mp";
	level.WeaponArray[36] = "qbb95_mp";
	level.WeaponArray[37] = "lsat_mp";
	level.WeaponArray[38] = "hamr_mp";
	
	level.WeaponArray[39] = "svu_mp";
	level.WeaponArray[40] = "dsr50_mp";
	level.WeaponArray[41] = "ballista_mp";
	level.WeaponArray[42] = "as50_mp";
	
	level.WeaponArray[43] = "minigun_wager_mp";
	level.WeaponArray[44] = "m32_wager_mp";
	
	//level.WeaponArray[41] = "riotshield_mp";
}
onPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");
	level.lastkilled = self;
	if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
	else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
	if (self.istargted) { level.targtedplayers--; }
	if (isDefined(self.waypointHUD)) { self.waypointHUD destroy(); }
}
onPlayerDisconnect()
{
	self endon("death");
	self waittill("disconnect");
	if (self.istargted) { level.targtedplayers--; }
	if (isDefined(self.waypointHUD)) { self.waypointHUD destroy(); }
}
WatchForFallOutOfMap()
{
	self endon("death");
	self endon("disconnect");
	while(true)
	{
		if (self.origin[2] < level.belowmapdeathbarrier)
		{
			if (self.savedfromthedepths)
			{ 
				self iprintln("^3You just fell off the map, you were saved this time but not the next time!");
				self iprintln("You lost everything in your inventory!");
				if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
				else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
				self.invgun = [];
				self.invboo = [];
				self.invabi = [];
				self.invaat = [];
				for(x=0;x<6;x++){ self.invgun[x] = ""; }
				for(x=0;x<6;x++){ self.invboo[x] = ""; }
				for(x=0;x<6;x++){ self.invabi[x] = ""; }
				for(x=0;x<6;x++){ self.invaat[x] = ""; }
				n = 0;
				while(true) { n = RandomIntRange(0,8); if (level.lca[n] >= 0) { break; } wait .05; }
				self setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
				wait .5;
				self.savedfromthedepths = false;
			}
			else { self suicide(); }
		}
		wait 1;
	}
}
init_SurvivalGames()
{
	level endon("game_ended");
	level.trapsqueue = []; 
	level.trapsqueueplayers = [];
	level.lca = []; // Active locations, Storage of indexes in the lc array.
	level.startalive = true; // While true new joiners can play in the round. Once the game starts and peacetime ends, this will become false.
	level.peacetime = false; // While true, everyone has godmode and can collect loot boxes.
	level.deadmansskybarrier = 1000; // The Hight value all dead players must mantain to inorder to not be telported back to spawn.
	level.finalspawnpoint = (0,0,0); // The center point that used as the spawn point.
	for(x=0;x<8;x++) { level.lca[x] = -1; } // All 8 active crates are assigned -1, meaning not spawend.
	level waittill("prematch_over");
	if (!level.debugger)
	{
		for(p=0;p<10;p++)
		{
			iprintln("^6Game starting in ^3" + (10 - p));
			wait 1;
		}
	}
	level thread init_MapEdit();
	level.time = 600; // 10 minutes total
	level thread LootBox_Spawner();
	level.peacetime = true;
	if (level.debugger) { return; }
	level.startalive = false;
	// Createing the HUD
	level.timestring = "Time left: 10 Minutes 0 Seconds";
	level.timerHUDMinute = CreateText(level.timestring, 2, 300, 0, (1,1,1), 1, 50, true, true, true, true);
	level.alivestring = "Players Alive: 1";
	level.aliveHUD = CreateText(level.alivestring, 2, 300, 20, (1,1,1), 1, 50, true, true, true, true);
	min = 10;
	sec = 0;
	count = 18;
	foreach(player in level.players) { player StartingLoadout(); }
	while(level.time > 540) 
	{ 
		wait 1; 
		level.time--; 
		if (level.time == 550) { iprintln("^3Peace time ends in 10 seconds!"); }
		if (level.time == 545) { iprintln("^1Peace time ends in 5 seconds!"); }
		min = int(floor(level.time / 60));
		sec = int(level.time - (min * 60));
		level.timestring = "Time left: " + min + " Minutes " + sec + " Seconds";
		level.timerHUDMinute setSafeText(level.timestring);
		count = 0;
		foreach(player in level.players)
		{
			if (IsAlive(player) && player.iscoolfordisgame)
			{
				count++;
			}
		}
		level.alivestring = "Players Alive: " + count;
		level.aliveHUD setSafeText(level.alivestring);
	}
	level.peacetime = false;
	level.startalive = false;
	foreach(player in level.players)
	{
		if (IsAlive(player))
		{
			player DisableInvulnerability();
		}
	}
	iprintln("^1Peace time over! You can now kill each other!");
	while(level.time > 0) 
	{ 
		wait 1; 
		level.time--;
		min = int(floor(level.time / 60));
		sec = int(level.time - (min * 60));
		level.timestring = "Time left: " + min + " Minutes " + sec + " Seconds";
		level.timerHUDMinute setSafeText(level.timestring);
		count = 0;
		foreach(player in level.players)
		{
			if (IsAlive(player) && player.iscoolfordisgame)
			{
				count++;
			}
		}
		level.alivestring = "Players Alive: " + count;
		level.aliveHUD setSafeText(level.alivestring);
		if (count == 1) 
		{ 
			target = level.dahost;
			foreach(player in level.players)
			{
				if (IsAlive(player) && player.iscoolfordisgame)
				{
					target = player;
				}
			}
			level thread maps/mp/gametypes/_globallogic::endgame("tie", "^2" + target.name + " has won the game!");
		}		
	}
	target = level.dahost;
	dis = 999999;
	foreach(player in level.players)
	{
		if (IsAlive(player) && player.iscoolfordisgame)
		{
			if (Distance(player.origin, level.finalspawnpoint) < dis)
			{
				dis = Distance(player.origin, level.finalspawnpoint);
				target = player;
			}
		}
	}
	level thread maps/mp/gametypes/_globallogic::endgame("tie", "^2" + target.name + " has won the game!");
}
