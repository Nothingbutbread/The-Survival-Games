getOrigin()
{
	self endon("death");
	self endon("disconnect");
	while(true)
	{
		self iprintln(self.origin);
		wait 3;
	}
}
StartingLoadout()
{
	self SetActionSlot(1, "");
	self SetActionSlot(2, "");
	self SetActionSlot(3, "");
	self SetActionSlot(4, "");
	self.zperks = [];
	self takeAllWeapons();
	self.spawnWeapons[0] = "knife_ballistic_mp"; //Primary
	self.spawnWeapons[1] = "knife_held_mp"; //Secondary
	self.spawnWeapons[2] = ""; //Lethal
	self.spawnWeapons[3] = ""; //Tacitcal
	self.spawnWeapons[4] = "knife_mp"; //Extra
	for (i = 0; i < 5; i++)
	{
		if (isDefined(self.spawnWeapons[i]))
		{
			self GiveWeapon(self.spawnWeapons[i]);
			self setWeaponAmmoClip(self.spawnWeapons[i], weaponClipSize(self.spawnWeapons[i]));
			self GiveStartAmmo(self.spawnWeapons[i]);
			self SwitchToWeapon(self.spawnWeapons[0]); 
		}
		wait 0.05;
	}
}
GiveGun(weapon, camo)
{
	if (weapon == "") { return ""; }
	if (!isDefined(camo)) { camo = 3; }
	oldweapon = self.currentWeapon;
	//if (!isanotWeapon(weapon)) { self TakeWeapon(self.currentWeapon); }
	self TakeWeapon(self.currentWeapon);
	self GiveWeapon(weapon);
	self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
	self SwitchToWeapon(weapon);
	self setcamo(camo, weapon);
	self SwitchToWeapon(weapon);
	self GiveStartAmmo(weapon);
	if (self CheckForLostGun()) { self GiveGun("knife_held_mp", 3); } // The player must have given himself a dupe, replenishes gun slot.
	return oldweapon;
}
CheckForLostGun()
{
	count = 0;
	foreach (gun in self GetWeaponsList())  { count++; }
	if (count >= 3) { return false; } // The player should always have 3 weapons. Otherwise he is missing one.
	return true;
}
isanotWeapon(gun)
{
	for(x=0;x<level.WeaponArray2.size;x++) { if (level.WeaponArray2[x] == gun) { return true; } }
	for(x=0;x<level.WeaponArray3.size;x++) { if (level.WeaponArray3[x] == gun) { return true; } }
	return false;
}
// id = Index to acess the item array
// gun = item name
// replace = boolean, If the inventory is full, when true, will replace the highlighted item. Otherwise it's not added.
// index is the ideal location to place the item in the inventory array.
add_Thing_To_Inventory(id, item, replace, index)
{
	if (id < 1) { return; }
	max = self.invlimmit[id - 1]; // Max is always the size max and the index value that shouldn't be reached.
	if (!isDefined(index)) { index = self.invlimmit[id - 1] - 1; }
	if (!isDefined(replace)) { replace = true; }
	if (index >= max) { index = self.invlimmit[id - 1] - 1; self iprintln("^3Warning: ^7Code 1 error detected and auto-corrected!"); }
	filled = true;
	array = [];
	if (id == 1) { array = self.invgun; }
	else if (id == 2) { array = self.invboo; }
	else if (id == 3) { array = self.invabi; }
	else { self iprintln("^1Game Error: ^3Function: add_Thing_To_Inventory ^1got an invalid id!\n^6Report this to the dev!"); array = self.invgun; }
	for(x=0;x<max;x++) 
	{ 
		if (array[x] == "") 
		{ 
			filled = false;
			index = x; 
			break; 
		} 
	}
	if (filled)
	{
		if (index < max) { array[index] = item; }
		else if (replace) { array[max - 1] = item; }
	}
	else 
	{ 
		if (index < max) { array[index] = item; }
	}
	if (id == 1) { self.invgun = array; }
	else if (id == 2) { self.invboo = array; }
	else if (id == 3) { self.invabi = array; }
}
setcamo(camo, g)
{
	if (!isdefined(g))
		g = self getCurrentWeapon();
	if (g != "minigun_wager_mp" && "m32_wager_mp" != g)
	{
		self takeWeapon(g);
		self giveWeapon(g,0,true(camo,0,0,0,0));
	}
}
// Used to determine the type id of an item from it's display string.
// The returned value is used to index into the inventory.
whatisthatobject(str)
{
	if ("Hearty" == str) { return 2; } // Booster
	else if ("Speedo" == str) { return 2; } 
	else if ("Quick Heal" == str) { return 2; } 
	else if ("Vanish" == str) { return 2; }
	else if ("Restock" == str) { return 2; } 
	else if ("Unlimmited Clip" == str) { return 2; } 
	else if ("New Camo" == str) { return 2; } 
	else if ("Birds Eye View" == str) { return 2; } 
	else if ("Loot Box Hack" == str) { return 2; }
	else if ("Double Tap II" == str) { return 3; } 
	else if ("Unlimmited Ammo" == str) { return 3; } 
	else if ("Electric Cherry" == str) { return 3; } 
	else if ("Dynamic Camo" == str) { return 3; } 
	else if ("Gun Game" == str) { return 3; }
	else if ("Speed Cola" == str) { return 9; } 
	else if ("Double Tap" == str) { return 9; } 
	else if ("Stamina Up" == str) { return 9; } 
	else if ("Scrounger" == str) { return 9; } 
	else if ("Resistance" == str) { return 9; } 
	else { return 1; } // A weapon
}
// Takes a size value and two intergers for the range.
// Returns an array of values that fall in the range and are unique.
RandIntArrayNoDupe(size, min, max)
{
	nums = [];
	if ((max - min) < size) { return nums; } // When the size is larger than the range, the function breaks.
	while(nums.size < size)
	{
		n = RandomIntRange(min, max);
		x = 0;
		while(x < nums.size)
		{
			if (nums[x] == n)
			{ 
				n++;
				if (n >= max) { n = min; }
				x = 0;
			}
			else { x++; }
		}
		nums[nums.size] = n;
	}
	return nums;
}
ValidforTrueUnlimmitedAmmo(g)
{
	if (!isDefined(g)) { g = self.currentWeapon; }
	if (g == "smaw_mp" || g == "usrpg_mp" || g == "m32_wager_mp" || g == "crossbow_mp" || g == "knife_ballistic_mp") { return false; }
	return true;
}
LootCreateDupeCheck(index, location)
{
	if (level.lca[index] != -1) { return false; } // There is an active create here, cancel!
	for(x=0;x<8;x++) { if (level.lca[x] == location) { return false; }  }
	return true;
}
DisplayStringMod(string, limmit)
{
	s = "";
	if (limmit < string.size)
	{
		for(x=0;x<limmit;x++) { s += string[x]; }
	}
	else { s = string; }
	return s;
}
AntiEndgame()
{
	level.hostforcedend = 1;
	self waittill( "menuresponse" );
	level.hostforcedend = 0;
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
DeleteDeathBarriers()
{
    ents = getEntArray();
    for ( index = 0; index < ents.size; index++ )
    {
    	if(isSubStr(ents[index].classname, "trigger_hurt"))
    		ents[index].origin = (0, 0, 9999999);
    }
}
SpawnIcon(origin, icon, onEntity)
{
	Objective_Add(level.mmiconsspawned, "active", origin);
	Objective_Icon(level.mmiconsspawned, icon);
	
	if (isDefined(onEntity))
		Objective_OnEntity(level.mmiconsspawned, onEntity);
	level.mmiconsspawned++;
}

