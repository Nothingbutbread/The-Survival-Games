DeadMan_Spectate()
{
	self endon("disconnect");
	self hide();
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 1);
	self iprintln("^1You're dead, Hold ADS to move around freely above the map!");
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(true) 
	{
		if (self adsbuttonpressed()) 
		{ 
			obj moveTo(playerAnglesToForward(self, 50), 0.1); 
		}
		if (self.origin[2] < level.deadmansskybarrier)
		{
			obj moveTo((level.finalspawnpoint[0], level.finalspawnpoint[1], level.deadmansskybarrier + 100), 0.1); 
			// 
			self iprintln("^1You can not go there!");
			wait .1;
		}
		wait .1; 
	}
	self unlink();
    obj delete();
}
Host_Toggle_Noclip(play)
{
    if (!isDefined(play)) { play = self; }
	if (play != self) { self iprintln("Toggled Noclip for " + play.name); }
	
	if (!isDefined(play.noclip)) { play.noclip = false; }
	if (!play.noclip)
	{
		play.noclip = true;
		play thread Dev_Noclip();
		play iprintln("Noclip ^2Enabled!. Press [{+gostand}] to move");
	}
	else
	{
		play.noclip = false;
		play iprintln("Noclip ^1Disabled!");
	}
}
Dev_Noclip()
{
	self endon("disconnect");
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(self.noclip) { if (self jumpbuttonpressed()) { obj moveTo(playerAnglesToForward(self, 50), 0.1); } wait .1; }
	self unlink();
    obj delete();
}




