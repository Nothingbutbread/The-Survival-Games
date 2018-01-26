init_HUDS()
{
	// Inventory Menu
	self.inventory_display_string = "Inventory Menu\nWeapons\nBoosters\nAbilities\n>--------<\n>--------<\n>--------<\nExit Menu";
	self.inventory_menu_open = false;
	self.inventory_menu_pos = 0;
	self.inventory_menu_menu = -1;
	self.inventory_menu_HUD = self CreateText("Inventory Menu\nWeapons\nBoosters\nAbilities\n>--------<\n>--------<\n>--------<\nExit Menu", 2, 100, 0, (0,.7,0), 0, 10, true, false, true, true);
	self.inventory_menu_BG = self SpawnShader("white", -190, 0, 150, 250, (0,0,0), 0, 5);
	self.inventory_menu_Scroller = self SpawnShader("white", -190, 25, 150, 25, (1,1,1), 0, 5);
	
	self.invlimmit = []; // First index is max on each type of good that can be held.
	self.invlimmit[0] = 2; self.invlimmit[1] = 3; self.invlimmit[2] = 2; // Default player can hold 2 guns, 3 boosters, 2 abilities
	self.invgun = [];
	self.invboo = [];
	self.invabi = [];
	for(x=0;x<6;x++){ self.invgun[x] = ""; } // Gunslots
	for(x=0;x<6;x++){ self.invboo[x] = ""; } // Boosters
	for(x=0;x<6;x++){ self.invabi[x] = ""; } // Abilities
	
	self thread Menu_Inventory_Open_Bind();
	// Create / Occupation menu
	self.loot_menu_Scroller = self SpawnShader("white", -190, 25, 150, 25, (1,1,1), 0, 5);
	self.loot_menu_pos = 0;
}
RebuildHUDS()
{
	self.inventory_menu_HUD setSafeText(self.inventory_display_string);
}
Menu_Inventory_Update_Menu()
{ // self.inventory_menu_menu controls what menu is displayed. -1 = Occupation menu 0 = main menu, 1 = weapons, 2 = boosters, 3 = abilties
	if (self.inventory_menu_menu == 0) { self.inventory_display_string = "Inventory Menu\nWeapons\nBoosters\nAbilities\n>--------<\n>--------<\n>--------<\nExit Menu"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else if (self.inventory_menu_menu == -1) { self.inventory_display_string = "Select Class!\nAddict\nBookie\nWarrior\nTank\nScout\nAthlete\nPirate"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else
	{
		str = "";
		if (self.inventory_menu_menu == 1) { str = "Stored Weapons"; array = self.invgun; }
		else if (self.inventory_menu_menu == 2) { str = "Boosters"; array = self.invboo; }
		else if (self.inventory_menu_menu == 3) { str = "Stored Abilties"; array = self.invabi; }
		for(x=0;x<6;x++)
		{
			if (array[x] != "") 
			{ 
				str += "\n";
				if (self.inventory_menu_menu == 1) { str += self DisplayStringMod(array[x], 16); }
				else { str += array[x]; } 
			}
			else { str += "\n>--------<"; }
		}
		str += "\nBack";
		self.inventory_display_string = str; 
		self.inventory_menu_HUD setSafeText(self.inventory_display_string);
	}
}
Menu_Inventory_Controls()
{
	self endon("death");
	self endon("disconnect");
	while(self.inventory_menu_open)
	{
		if (self actionslotonebuttonpressed() && self.inventory_menu_pos > 0)
		{
			self.inventory_menu_Scroller moveOverTime(.05);
			self.inventory_menu_Scroller.y -= 24;
			self.inventory_menu_pos--;
			wait .05;
		}
		else if (self actionslottwobuttonpressed()  && self.inventory_menu_pos < 6)
		{
			self.inventory_menu_Scroller moveOverTime(.05);
			self.inventory_menu_Scroller.y += 24;
			self.inventory_menu_pos++;
			wait .05;
		}
		else if (self usebuttonpressed())
		{
			self Menu_Inventory_Run_Cmd();
			wait .2;
		}
		else if (self jumpbuttonpressed())
		{
			self Menu_Inventory_Close();
			return;
		}
		wait .05;
	}
}
Menu_Inventory_Run_Cmd()
{
	// self.inventory_menu_pos = 0;
	// self.inventory_menu_menu = 0;
	if (self.inventory_menu_pos == 6 && self.inventory_menu_menu == 0) { self Menu_Inventory_Close(); }
	else if (self.inventory_menu_pos == 3 && self.inventory_menu_menu == 0 && level.debugger)
	{ 
		self thread Host_Toggle_Noclip();
	}
	else if (self.inventory_menu_menu == -1) { self.inventory_menu_menu = 0; self Menu_Inventory_Update_Menu(); self init_Occupation(self.inventory_menu_pos); }
	else if (self.inventory_menu_pos == 6 && self.inventory_menu_menu > 0) { self.inventory_menu_menu = 0; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 0 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 1; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 1 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 2; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 2 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 3; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_menu == 1) 
	{ 
		if (self.invgun[self.inventory_menu_pos] != "")
		{
			oldweapon = self thread GiveGun(self.invgun[self.inventory_menu_pos]);
			if (oldweapon != "") { self.invgun[self.inventory_menu_pos] = oldweapon; }
			else { self.invgun[self.inventory_menu_pos] = ""; }
			self Menu_Inventory_Update_Menu();
		}
	}
	else if (self.inventory_menu_menu == 2) 
	{ 
		if (self.invboo[self.inventory_menu_pos] != "")
		{
			self thread Use_Booster(self.invboo[self.inventory_menu_pos]);
			self.invboo[self.inventory_menu_pos] = "";
			self Menu_Inventory_Update_Menu();
		}
		else { return; }
	}
	else if (self.inventory_menu_menu == 3) 
	{ 
		if (self.invabi[self.inventory_menu_pos] != "")
		{
			self thread Use_Ability(self.invabi[self.inventory_menu_pos]);
			self.invabi[self.inventory_menu_pos] = "";
			self Menu_Inventory_Update_Menu();
		}
		else { return; }
	}
	else { return; }
	wait .5;
	
}
Menu_Inventory_Open_Bind()
{
	self endon("death");
	self endon("disconnect");
	while(!self.inventory_menu_open && self.iscoolfordisgame)
	{
		if (self adsbuttonpressed() && self meleebuttonpressed() && !self.loot_menu_open) { self thread Menu_Inventory_Open(); }
		if (self adsbuttonpressed() && self meleebuttonpressed() && self.loot_menu_open) { self iprintln("^1Another menu is already open!"); }
		wait .1;
	}
}
Menu_Inventory_Open()
{
	self.inventory_menu_open = true;
	self Menu_Inventory_Update_Menu();
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.inventory_menu_BG.color = (0,0,0);
	self.inventory_menu_HUD.color = (0,.7,0);
	self.inventory_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 1;
	self.inventory_menu_BG.alpha = 1;
	self.inventory_menu_Scroller.alpha = 1;
	wait .5;
	self thread Menu_Inventory_Controls();
}
Menu_Inventory_Close()
{
	self.inventory_menu_open = false;
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.inventory_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 0;
	self.inventory_menu_BG.alpha = 0;
	self.inventory_menu_Scroller.alpha = 0;
	wait .5;
	self thread Menu_Inventory_Open_Bind();
}
CreateText(item, fontScale, x, y, color, alpha, sort, text, allpeeps, foreground, normal)
{
	if (!allpeeps)
		hud = self createFontString("objective", fontScale);
	else
		hud = level createServerFontString("objective", fontScale);
	if (!text)
    	hud setValue(item);
    else
    	hud setSafeText(item);
    hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
    hud.sort = sort;
	hud.foreground = foreground;
	if (!isDefined(normal) || normal)
	{
		hud.alignX = "left";
		hud.horzAlign = "left";
		hud.vertAlign = "center";
	}
	return hud;
}
SpawnShader(shader, x, y, width, height, color, alpha, sort)
{
	hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    hud.foreground = true;
    return hud;
}
overflowfix()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	
	test = level createServerFontString("default", 1);
	test setText("xTUL");
	test.alpha = 0;

	if(GetDvar("g_gametype") == "sd")
    	limit = 35;
    else
    	limit = 45; 

	while(1)
	{
		level waittill("textset"); 
		if(level.strings.size >= limit)
		{
			test ClearAllTextAfterHudElem();
			level.strings = [];//re-building the string array
			//iprintln("^1Debug: ^5Overflow prevented!"); //Remove after finishing your menu.
			level.timerHUDMinute setSafeText(level.timestring);
			level.aliveHUD setSafeText(level.alivestring);
			foreach(player in level.players) { player thread RebuildHUDS(); }
		}
	}
}

setSafeText(text)
{
    if (!isInArray(level.strings, text))
    {
        level.strings[level.strings.size] = text;
        self setText(text);
        level notify("textset");
    }
    else
        self setText(text);
}
// From Cooljayz Zombieland
CreateWaypoint(shader, origin, width, height, alpha, allplayers)
{
	if (allplayers) { createwaypoint = NewHudElem(); }
    else { createwaypoint = NewClientHudElem(self); }
    createwaypoint SetShader(shader, width, height);
	createwaypoint SetWayPoint(true);   
	createwaypoint.x = origin[0];
	createwaypoint.y = origin[1];
	createwaypoint.z = origin[2]; 
	createwaypoint.alpha = alpha;
	createwaypoint.archived = false;
	return createwaypoint;
}

