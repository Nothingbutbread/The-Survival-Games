init_Occupation(in)
{
	if (in == 0) 
	{
		self.occupation = "Addict";
		self.invlimmit[1] = 6;
		self thread Occupation_Addict_Streaker();
		self iprintln("You selected the Addict Class!");
		self iprintln("^2Your boosters have been buffed and kills give you extra health and speed!");
	}
	else if (in == 1) 
	{ 
		self.occupation = "Bookie";
		self thread Occupation_Brookie_Streaker();
		self iprintln("You selected the Bookie Class!");
		self iprintln("^2Your loot box odds are better and a 3 kill streak will give you a free rare loot box");
	}
	else if (in == 2) 
	{ 
		self.occupation = "Warrior";
		self.invlimmit[0] = 6;
		self.occupation_bonus = true;
		self Perk_Speedcola();
		self thread Occupation_Warrior_Streaker();
		self iprintln("You selected the Warrior Class!");
		self iprintln("^2You can carry 6 guns and reload faster. A 3 kill streak gives you all your perks!");
	}
	else if (in == 3) 
	{ 
		self.occupation = "Tank";
		self.invlimmit[0] = 6; 
		self.invlimmit[1] = 6; 
		self.invlimmit[2] = 6;
		self.basehealth = 150;
		self.maxhealth = self.basehealth;
		self.health = self.basehealth;
		self thread Occupation_Tank_Streaker();
		self iprintln("You selected the Tank Class!");
		self iprintln("^2You have 50 extra health, max inventory spcae and kills refill your mag.\nUnlimmited ammo boosters last twice as long.");
	}
	else if (in == 4)
	{ 
		self.occupation = "Scout";
		self Perk_Resistance();
		self Perk_Scrounger();
		self Perk_Staminia_up();
		self thread Occupation_Scout_Streaker();
		self iprintln("You selected the Scout Class! ^1This class is not complete yet!");
		self iprintln("^2You have stealth perks and speed perks. Birds Eye view lasts twice as long.\n3 kills and on autogive a Birds eye view booster effect.");
	}
	else if (in == 5)
	{ 
		self.occupation = "Athlete";
		self setmovespeedscale(1.25);
		self.basespeed = 1.25;
		self.curspeed = 1.25;
		self Perk_Staminia_up();
		self thread Occupation_Athlete_Streaker();
		self iprintln("You selected the Athlete Class!");
		self iprintln("^2You move speed is increased, stacking with the speedo booster and speedo boosters last twice as long.");

	}
	else if (in == 6)
	{ 
		self.occupation = "Pirate";
		self.invlimmit[0] = 6; 
		self.invlimmit[1] = 6; 
		self.invlimmit[2] = 6;
		self iprintln("You selected the Pirate Class! ^1This class is undergoing major revision!");
		self iprintln("^2You have max inventory space and loot box odds ... for now.");
		//self thread Occupation_Pirate_Streaker();
		self thread Occupation_Brookie_Streaker();
	}
}
Occupation_Addict_Streaker()
{
	self endon("death");
	self endon("disconnect");
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			self.basehealth += 5;
			self.basespeed += .05;
			if (self.basehealth > self.maxhealth) { self.basehealth = self.maxhealth; }
			if (self.basespeed > self.curspeed) { self setmovespeedscale(self.basespeed); }
		}
		wait .05;
	}
}
Occupation_Brookie_Streaker()
{
	self endon("death");
	self endon("disconnect");
	streak = 0;
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			streak++;
			if (streak == 2)
			{
				self.occupation_bonus = true;
				self iprintlnbold("2 killstreak bonus: ^2The next loot crate you open will be Rare!");
				break;
			}
		}
		wait .05;
	}
}
Occupation_Warrior_Streaker()
{
	self endon("death");
	self endon("disconnect");
	streak = 0;
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			streak++;
			if (streak == 3)
			{
				self iprintlnbold("3 killstreak bonus: ^2All perks obtained!");
				self ClearPerks();
				self Reset_Perks();
				self Perk_Speedcola();
				self Perk_Doubletap();
				self Perk_Staminia_up();
				self Perk_Scrounger();
				self Perk_Resistance();
				self.basespeed += .2;
				if (self.curspeed < self.basespeed) { self setmovespeedscale(self.basespeed); }
				break;
			}
		}
		wait .05;
	}
}
Occupation_Tank_Streaker()
{
	self endon("death");
	self endon("disconnect");
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
		}
		wait .05;
	}
}
Occupation_Scout_Streaker()
{
	self endon("death");
	self endon("disconnect");
	streak = 0;
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			streak++;
			if (streak >= 3)
			{
				self notify("booster_bev"); 
				self thread Booster_BirdsEyeView();
			}
		}
		wait .05;
	}
}
Occupation_Athlete_Streaker()
{
	self endon("death");
	self endon("disconnect");
	streak = 0;
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			streak++;
			if (streak == 3)
			{
				self iprintlnbold("3 killstreak bonus: ^2Base movement speed increased 50%!");
				self.basespeed += .5;
				if (self.curspeed < self.basespeed) { self setmovespeedscale(self.basespeed); }
				break;
			}
		}
		wait .05;
	}
}
/*
Occupation_Pirate_Streaker()
{
	self endon("death");
	self endon("disconnect");
	i = self.pers["kills"];
	while(true)
	{
		if (self.pers["kills"] != i)
		{
			i = self.pers["kills"];
			for(y=1;y<4;y++)
			{
				for(x=0;x<6;x++)
				{
					if (level.lastkilled.inventory[y][x] != "")
					{
						self add_Thing_To_Inventory(y, level.lastkilled.inventory[y][x], false);
					}
				}
			}
		}
		wait .05;
	}
}
*/
