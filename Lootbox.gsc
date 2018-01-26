giveSupplyDrop()
{
	self.loot = [];
	for(x=0;x<6;x++) { self.loot[x] = ""; }
	luck = RandomIntRange(0,100);
	teir = 1;
	if (self.occupation == "Bookie" && !self.occupation_bonus)
	{
		if (luck < 45) { teir = 1; }
		else if (luck < 80) { teir = 2; }
		else { teir = 3; }
	}
	else if (self.occupation == "Bookie" && self.occupation_bonus) { teir = 3; self.occupation_bonus = false; }
	else
	{
		if (luck < 65) { teir = 1; }
		else if (luck < 90) { teir = 2; }
		else { teir = 3; }
	}
	if (teir == 1) { self thread LB_Common(); }
	else if(teir == 2) { self thread LB_Uncommon(); }
	else { self thread LB_Rare(); }
}
LB_Common()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(1,4); }
	else { items = RandomIntRange(2,4); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Common_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	self.lootboxrarity = "Common";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (.2,.2,.2);
	self.loot_menu_Scroller.color = (1,1,1);
	self.inventory_menu_HUD.color = (0,.7,0);
	self thread Menu_Loot_Open();
}
Generate_Common_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (luck >= 65){ retval = Loot_Common_gun(); } // 65% chance of gun
	else if (luck >= 90) { retval = Loot_Booster(); } // 25% chance of Booster
	else { retval = Loot_Perk(); } // 10% chance of a perk
	return retval;
}
Generate_Uncommon_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (luck >= 60) { retval = Loot_Uncommon_gun(); } // 40% chance of a gun
	else if (luck >= 30) { retval = Loot_Booster(); } // 30% chance of a booster
	else if (luck >= 10) { retval = Loot_Perk(); }  // 20% chance of a perk
	else { retval = Loot_Ability(); } // 10% chance for an ability
	return retval;
}
Generate_Rare_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (luck >= 70) { retval = Loot_Uncommon_gun(); } // 30% chance of a gun
	else if (luck >= 50) { retval = Loot_Booster(); } // 20% chance of a booster
	else if (luck >= 25) { retval = Loot_Perk(); }  // 25% chance of a perk
	else { retval = Loot_Ability(); } // 25% chance for an ability
	return retval;
}
LB_Uncommon()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(2,5); }
	else { items = RandomIntRange(3,5); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Uncommon_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	self.lootboxrarity = "Uncommon";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (0,0,.5);
	self.loot_menu_Scroller.color = (.5,0,0);
	self.inventory_menu_HUD.color = (0,.5,0);
	self thread Menu_Loot_Open();
}
LB_Rare()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(3,7); }
	else { items = RandomIntRange(4,7); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Rare_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus && items < 6)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	self.lootboxrarity = "Rare";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (0,0,1);
	self.loot_menu_Scroller.color = (1,0,0);
	self.inventory_menu_HUD.color = (0,1,0);
	self thread Menu_Loot_Open();
}
Menu_Loot_Open()
{
	self.loot_menu_open = true;
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.loot_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 1;
	self.inventory_menu_BG.alpha = 1;
	self.loot_menu_Scroller.alpha = 1;
	wait .5;
	self thread Menu_Loot_Controls();
}
Menu_Loot_Close()
{
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.loot_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 0;
	self.inventory_menu_BG.alpha = 0;
	self.loot_menu_Scroller.alpha = 0;
	wait .5;
	self.loot_menu_open = false;
}
Menu_Loot_Claim(index)
{
	if (self.loot[index] == "") { return; }
	type = whatisthatobject(self.loot[index]);
	if (type == 9) { self Give_Cool_Perk(self.loot[index]); }
	else  { self add_Thing_To_Inventory(type, self.loot[index], true); }
	self.loot[index] = "";
}
Menu_Loot_Controls()
{
	self endon("death");
	self endon("disconnect");
	self Menu_Loot_Update_Menu();
	while(self.loot_menu_open)
	{
		if (self actionslotonebuttonpressed() && self.loot_menu_pos > 0)
		{
			self.loot_menu_Scroller moveOverTime(.05);
			self.loot_menu_Scroller.y -= 24;
			self.loot_menu_pos--;
			wait .05;
		}
		else if (self actionslottwobuttonpressed()  && self.loot_menu_pos < 6)
		{
			self.loot_menu_Scroller moveOverTime(.05);
			self.loot_menu_Scroller.y += 24;
			self.loot_menu_pos++;
			wait .05;
		}
		else if (self jumpbuttonpressed()) // Takes all items
		{
			for(x=0;x<self.loot.size;x++) { self Menu_Loot_Claim(x); }
			self Menu_Loot_Close();
			wait .05;
		}
		else if (self usebuttonpressed())
		{
			if (self.loot_menu_pos == 6) { self Menu_Loot_Close(); return; }
			else if (self.loot[self.loot_menu_pos] == "") { self iprintln("^1Invalid Option"); }
			else { self Menu_Loot_Claim(self.loot_menu_pos); self.lootboxitemcount--; self Menu_Loot_Update_Menu(); }
			if (self.lootboxitemcount < 1) { self Menu_Loot_Close(); return; }
			wait .1;
		}
		wait .05;
	}
}
Menu_Loot_Update_Menu()
{ 
	str = self.lootboxrarity;
	for(x=0;x<6;x++)
	{
		if (self.loot[x] != "") 
		{ 
			str += "\n" + DisplayStringMod(self.loot[x], 16); 
		}
		else { str += "\n>--------<"; }
	}
	str += "\nExit Menu";
	self.inventory_display_string = str; 
	self.inventory_menu_HUD setSafeText(self.inventory_display_string);
}
LootBox_Spawner()
{
	level endon("game_ended");
	if (level.lc.size < 8) { return; } // 8 points must be defined to work.
	index = -1;
	while(true)
	{
		if (level.activelootboxes < 8)
		{
			index++;
			if (index >= 8) { index = 0; }
			location = RandomIntRange(0, level.lc.size); // Is atleast 8.
			level thread Spawn_LootCrate(index, location);
			wait .5;
		}
		else { wait 8; }
	}
}




