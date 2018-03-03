init_Occupation(in)
{
	if (in == 0) 
	{
		self.occupation = "Addict";
		self.invlimmit[1] = 6;
		self.invlimmit[2] = 6;
		self add_Thing_To_Inventory(2, "Speedo", true);
		self add_Thing_To_Inventory(3, "Resistant", true);
		self thread Occupation_Addict_Streaker();
		self iprintln("You selected the Addict Class!");
	}
	else if (in == 1) 
	{ 
		self.occupation = "Bookie";
		self.invlimmit[0] = 4; 
		self.invlimmit[1] = 4; 
		self.invlimmit[2] = 4;
		self.invlimmit[3] = 4;
		self thread Occupation_Brookie_Streaker();
		self iprintln("You selected the Bookie Class!");
	}
	else if (in == 2) 
	{ 
		self.occupation = "Warrior";
		self.invlimmit[0] = 6;
		self.occupation_bonus = true;
		self Perk_Speedcola();
		self thread Occupation_Warrior_Streaker();
		self iprintln("You selected the Warrior Class!");
	}
	else if (in == 3) 
	{ 
		self.occupation = "Tank";
		self.invlimmit[0] = 6; 
		self.invlimmit[1] = 6; 
		self.invlimmit[2] = 6;
		self.invlimmit[3] = 6;
		self.basehealth = 150;
		self.maxhealth = self.basehealth;
		self.health = self.basehealth;
		self thread Occupation_Tank_Streaker();
		self iprintln("You selected the Tank Class!");
	}
	else if (in == 4)
	{ 
		self.occupation = "Scout";
		self Perk_Resistance();
		self Perk_Scrounger();
		self Perk_Staminia_up();
		self.occupation_bonus = true;
		self thread Occupation_Scout_Streaker();
		self iprintln("You selected the Scout Class!");
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
	}
	else if (in == 6)
	{ 
		self.occupation = "Specialist";
		self.invlimmit[3] = 6;
		self.occupation_bonus = true;
		self thread Occupation_Speicalist_Streaker();
		self iprintln("You selected the Specialist Class!");
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
			self.basehealth += 6;
			self.basespeed += .06;
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
			}
			if (streak == 3)
			{
				self iprintlnbold("3 killstreak bonus: ^2Max Inventory Space!");
				self.invlimmit[0] = 6; 
				self.invlimmit[1] = 6; 
				self.invlimmit[2] = 6;
				self.invlimmit[3] = 6;
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
				self notify("perk_stop_sixithsense");
				self Reset_Perks();
				self Perk_Speedcola();
				self Perk_Doubletap();
				self Perk_Staminia_up();
				self Perk_Scrounger();
				self Perk_Resistance();
				self Perk_Mulekick();
				self thread Perk_sixithsense();
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
				self iprintlnbold("3 killstreak bonus: ^2Base movement speed increased 40 percent!");
				self.basespeed += .4;
				if (self.curspeed < self.basespeed) { self setmovespeedscale(self.basespeed); }
				self.invlimmit[0] = 6; 
				self.invlimmit[1] = 6; 
				self.invlimmit[2] = 6;
				self.invlimmit[3] = 6;
				break;
			}
		}
		wait .05;
	}
}
Occupation_Speicalist_Streaker()
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
				self iprintlnbold("3 killstreak bonus: ^2Base movement and health increased!");
				self.basespeed += .2;
				if (self.curspeed < self.basespeed) { self setmovespeedscale(self.basespeed); }
				self.basehealth += 25;
				if (self.basehealth > 200) { self.basehealth = 200; }
				if (self.maxhealth < self.basehealth) { self.maxhealth = self.basehealth; }
				break;
			}
		}
		wait .05;
	}
}














