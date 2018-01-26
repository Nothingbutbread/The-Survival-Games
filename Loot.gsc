Give_Cool_Perk(str)
{
	if (str == "Speed Cola")
		self Perk_Speedcola();
	else if (str == "Double Tap")
		self Perk_Doubletap();
	else if (str == "Stamina Up")
		self Perk_Staminia_up();
	else if (str == "Scrounger")
		self Perk_Scrounger();
	else if (str == "Resistance")
		self Perk_Resistance();
}
Use_Ability(str)
{
	self notify("new_ability");
	if (str == "Double Tap II" ) { self thread Ability_DoubleTap2(); }
	else if (str == "Unlimmited Ammo") { self thread Ability_UnlimmitedAmmo(); }
	else if (str == "Gun Game") { self thread Ability_GunGame(); }
	else if (str == "Electric Cherry") { self thread Ability_ElectricCherry(); }
	else if (str == "Dynamic Camo") { self thread Ability_DynamicCamo(); }
}
Use_Booster(str)
{
	if (str == "Hearty") { self notify("booster_hearty"); self thread Booster_Hearty(); }
	else if (str == "Speedo") { self notify("booster_speedo"); self thread Booster_Speedo(); }
	else if (str == "Quick Heal") { self thread Booster_QuickHeal(); }
	else if (str == "Vanish") { self notify("booster_vanish"); self thread Booster_Vanish(); }
	else if (str == "Restock") { self thread Booster_Restock(); }
	else if (str == "Unlimmited Clip"){ self notify("booster_tua"); self thread Booster_True_Unlimmited_Ammo(); }
	else if (str == "New Camo") { self thread Booster_NewCamo(); }
	else if (str == "Birds Eye View") { self notify("booster_bev"); self thread Booster_BirdsEyeView(); }
	else if (str == "Loot Box Hack") { self thread Booster_TeleportToLootBox(); }
}
Booster_Speedo()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_speedo");
	self iprintlnbold("^5The Speedo Booster is now ^2Active!");
	self setmovespeedscale(self.basespeed * 2);
	self.curspeed = self.basespeed * 2;
	if (self.occupation == "Addict") { wait 20; }
	else if(self.occupation == "Athlete") { wait 30; }
	else { wait 15; }
	self setmovespeedscale(self.basespeed);
	self.curspeed = self.basespeed;
	self iprintlnbold("^5The Speedo Booster effect ^1Expired!");
}
Booster_Hearty()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_hearty");
	self.maxhealth = 200;
	self.health = self.maxhealth;
	self iprintlnbold("^5The Hearty Booster is now ^2Active!");
	if (self.occupation == "Addict") { wait 20; }
	else { wait 13; }
	self iprintlnbold("^5The Hearty Booster effect ^1Expired!");
	self.maxhealth = self.basehealth;
}
Booster_QuickHeal()
{
	self.health = self.maxhealth;
	self iprintlnbold("^5You just instantly healed!");
}
Booster_Vanish()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_vanish");
	self iprintlnbold("^5The Vanish Booster is now ^2Active!");
	self iprintln("Your weapons are disabled while the effect is active");
	self disableWeapons();
	if (self.occupation == "Addict") { wait 17; }
	else { wait 12; }
	self iprintlnbold("^3The Vanish Booster effect will expire in 3 seconds!");
	wait 3;
	self enableWeapons();
	self iprintlnbold("^5The Vanish Booster effect ^1Expired!");
}
Booster_Restock()
{
	foreach (gun in self GetWeaponsList())  
	{
		self setWeaponAmmoClip(gun, weaponClipSize(gun));
		self giveMaxAmmo(gun);
	}
	self iprintlnbold("^5Your held weapons have been refilled with ammo!");
}
Booster_True_Unlimmited_Ammo()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_tua");
	tick = 50;
	if (self.occupation == "Addict") { tick = 75; }
	else if (self.occupation == "Tank") { tick = 100; }
	self iprintlnbold("^5Unlimmited Clip Ammo ^2Active!");
	self iprintln("^3This effect only works bullet weapons!");
	self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
	wait .2;
	while(tick > 0)
	{
		if (ValidforTrueUnlimmitedAmmo(self.currentWeapon)) { self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon)); }
		wait .2;
		tick--;
	}
	self iprintlnbold("^5Unlimmited Clip Ammo ^1Disabled!");
}
Booster_NewCamo()
{
	camo = RandomIntRange(1,44);
	self setcamo(camo, self.currentWeapon);
	self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
	self giveMaxAmmo(self.currentWeapon);
	self iprintlnbold("^5Your held gun got a new camo and has been refilled with ammo!");
}
Booster_BirdsEyeView()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_bev");
	iprintln("^1" + self.name + " has Enabled UAV");
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 1);
	if (self.occupation == "Addict") { wait 15; }
	else if (self.occupation == "Scout") { wait 20; }
	else { wait 10; }
	self iprintlnbold("Birds Eye View has been ^1Disabled!");
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 0);
}
Booster_TeleportToLootBox()
{
	n = RandomIntRange(0,8);
	self setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
	self iprintln("^1Teleported to a random loot box!");
}
Ability_DoubleTap2()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Double tap II ^2Active!");
	while(true)
	{
		self waittill("weapon_fired", weapon);
		if (ValidforTrueUnlimmitedAmmo(weapon))
		{
			trace = BulletTrace(self GetEye(), self GetEye() + (AnglesToForward(self GetPlayerAngles()) * 10000000), true, self);
			MagicBullet(weapon, self GetTagOrigin("tag_weapon_right") + (AnglesToForward(self GetPlayerAngles()) * 50), trace["position"], self);
		}
		wait .2;
	}
}
Ability_DynamicCamo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Dynamic Camo ^2Active!");
	while(true)
	{
		camo = RandomIntRange(1,44);
		self setcamo(camo, self.currentWeapon);
		self giveMaxAmmo(self.currentWeapon);
		wait 10;
	}
}
Ability_UnlimmitedAmmo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Unlimmited Stock Ammo ^2Active!");
	while(true)
	{
		self giveMaxAmmo(self.currentWeapon);
		wait 1;
	}
}
Ability_GunGame()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Gun game ^2Active!");
	while(true)
	{
		wait 15;
		camo = RandomIntRange(1,44);
		weapon = Loot_Uncommon_gun();
		GiveGun(weapon, camo);
	}
}
Ability_ElectricCherry()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Electric Cherry ^2Active!");
	while(true)
	{
		self waittill("reload_start");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "j_head");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine1");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine4");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "pelvis");
		self PlaySound("wpn_taser_mine_zap");
		self EnableInvulnerability();
		RadiusDamage(self.origin,200,9999,50,self);
		wait .5;
		self DisableInvulnerability();
		wait 8;
	}
}
////////////////////////////////////////////
Loot_Ability()
{
	per = RandomIntRange(0, 5);
	if (per == 0) { return "Double Tap II"; }
	else if (per == 1) { return "Unlimmited Ammo"; }
	else if (per == 2) { return "Gun Game"; }
	else if (per == 3) { return "Electric Cherry"; }
	else if (per == 4) { return "Dynamic Camo"; }
}
Loot_Booster()
{
	per = RandomIntRange(0, 9);
	if (per == 0) { return "Hearty"; }
	else if (per == 1) { return "Speedo"; }
	else if (per == 2) { return "Quick Heal"; }
	else if (per == 3) { return "Vanish"; }
	else if (per == 4) { return "Restock"; }
	else if (per == 5) { return "Unlimmited Clip"; }
	else if (per == 6) { return "New Camo"; }
	else if (per == 7) { return "Birds Eye View"; }
	else if (per == 8) { return "Loot Box Hack"; }
}
Loot_Perk()
{
	per = RandomIntRange(0, 5);
	if (per == 0)
		return "Speed Cola";
	else if (per == 1)
		return "Double Tap";
	else if (per == 2)
		return "Stamina Up";
	else if (per == 3)
		return "Scrounger";
	else if (per == 4)
		return "Resistance";
}
Loot_Common_gun()
{
	att = RandIntArrayNoDupe(2, 0, 19);
	gun = RandomIntRange(0,19);
	if (gun >= 9) { str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]]; }
	else { str = level.WeaponArray[gun]; }
	return str;
}
Loot_Uncommon_gun()
{
	att = RandIntArrayNoDupe(3, 0, 22);
	gun = RandomIntRange(0, 43);
	if (gun >= 9) { str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]]; }
	else { str = level.WeaponArray[gun]; }
	return str;
}
Loot_Rare_gun()
{
	att = RandIntArrayNoDupe(3, 0, 22);
	gun = RandomIntRange(19,45);
	if (gun < 43) { str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]]; }
	else { str = level.WeaponArray[gun]; }
	return str;
}
Loot_Warrior_First()
{
	att = RandIntArrayNoDupe(3, 0, 19);
	gun = RandomIntRange(19,39);
	str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]];
	return str;
}



