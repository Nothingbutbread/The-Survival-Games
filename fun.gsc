Fun_Taunt()
{
	self endon("death");
	self endon("disconnect");
	if (self.cantaunt)
	{
		self.cantaunt = false;
		t = RandomIntRange(0,10);
		iprintln(self.name + "^" + t + " " + Fun_Taunt_Text());
		wait 8;
		self.cantaunt = true;
	}
	else { self iprintln("You must wait atleast 8 seconds before taunting again."); }
}
Fun_Taunt_Text()
{
	t = RandomIntRange(0,53);
	if (t == 0) { return "it's time to die assholes!"; }
	else if (t == 1) { return "I like the sound your corpse makes when I shoot it!"; }
	else if (t == 2) { return "I will fuck yo moma harder than she did your face!"; }
	else if (t == 3) { return "where the hell you going punk?"; }
	else if (t == 4) { return "where's your moma now pussy?"; }
	else if (t == 5) { return "I like turtles!"; }
	else if (t == 6) { return "overhere num nuts!"; }
	else if (t == 7) { return "come get sum'"; }
	else if (t == 8) { return "what a fucking Donald Trump Surporter!"; }
	else if (t == 9) { return "what a fucking Hillary Clinton Surprter!"; }
	else if (t == 10) { return "sorry about fucking your sister " + level.lastkilled.name; }
	else if (t == 11) { return "eat a dick!"; }
	else if (t == 12) { return "eat my moose cock!"; }
	else if (t == 13) { return "cunt fuckers!"; }
	else if (t == 14) { return "I like big grey elephants that sniff my dogs ass!"; }
	else if (t == 15) { return "doink!"; }
	else if (t == 16) { return "java.lang.nullPointerException"; }
	else if (t == 17) { return "big big small small grampa dick!"; }
	else if (t == 18) { return "want to hear a joke about my dick? Sorry it's too long!"; }
	else if (t == 19) { return "ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh!"; }
	else if (t == 20) { return "surprise motherfuckers!"; }
	else if (t == 21) { return "the only way you win is by not playing!"; }
	else if (t == 22) { return "here piggy piggy!"; }
	else if (t == 23) { return "i'm so hot you'd get roasted just looking at me!"; }
	else if (t == 24) { return "Have you seen " + level.lastkilled.name + "'s dick? You'll need a microscope to see it"; }
	else if (t == 25) { return "I used to be an adventurer like you, then I took an arrow to the knee."; }
	else if (t == 26) { return "I used to be an adventurer like you, then I stuck my dick in " + level.lastkilled.name; }
	else if (t == 27) { return "why the fuck am I here? You'll so dumb!"; }
	else if (t == 28) { return "man who sit on toliet is high on pot."; }
	else if (t == 29) { return "get the fuck outa here kid!"; }
	else if (t == 30) { return "<-- is a retard!"; }
	else if (t == 31) { return "bomb! crack! ... sorry my dick is going at it!"; }
	else if (t == 32) { return "I like ass!"; }
	else if (t == 33) { return "you're so dumb, your playing Black ops 2!"; }
	else if (t == 34) { return "fuck fuck fuck fuck fuck fuck fuck fuck you!"; }
	else if (t == 35) { return "fuck you you you you you you you you you you!"; }
	else if (t == 36) { return "come get me you bitches!"; }
	else if (t == 37) { return "stop camping like a little bitch and bring some heat!"; }
	else if (t == 38) { return "fucking campers!"; }
	else if (t == 39) { return "congrats kid, do you want a cookie!"; }
	else if (t == 40) { return "the beef is so raw in here it's mooing!"; }
	else if (t == 41) { return "hey guys I am gay as fuck!"; }
	else if (t == 42) { return "Why so much salt?"; }
	else if (t == 43) { return "come rub me, I like it!"; }
	else if (t == 44) { return "come and line up, little kids! I'll make this quick."; }
	else if (t == 45) { return "I would lend a hand but you're already down all limbs!"; }
	else if (t == 46) { return "hey your dad called, he needs a hole to get into!"; }
	else if (t == 47) { return "hey " + level.lastkilled.name + " I will bury you in dog poop!"; }
	else if (t == 48) { return "Go to hell: " + level.lastkilled.name; }
	else if (t == 49) { return "Go back to preschool, get outta the genepool, try your best to not drool!"; }
	else if (t == 50) { return "Hey guys this is an M rated game and y'all sound like your under 17!"; }
	else if (t == 51) { return "$ python3 fuckdisshit.py go kill yourself >> Good!"; }
	else if (t == 52) { return "Subscribe to Nothingbutbread on youtube, he made this!"; }
}
// A is the attacker
// v in the victem
Fun_taunt_trap(a, v)
{
	t = RandomIntRange(0,13);
	if (t == 0) { return a.name + ": where is your moma now " + v.name + " ?"; }
	else if (t == 1) { return a.name + ": eat lead " + v.name + "!"; }
	else if (t == 2) { return a.name + ": I just fucked you up boi!"; }
	else if (t == 3) { return a.name + ": did you really think I'd let you go there " + v.name + " ?"; }
	else if (t == 4) { return a.name + ": hey " + v.name + " I thought you were tougher than that!"; }
	else if (t == 5) { return a.name + ": I like the smell of roast beef!"; }
	else if (t == 6) { return a.name + ": You were on fire " + v.name + " and i'm being literal here!"; }
	else if (t == 7) { return a.name + ": another day, another dead corpse to burn!"; }
	else if (t == 8) { return a.name + ": eat it " + v.name + "!"; }
	else if (t == 9) { return a.name + ": I would tee bag your corpse " + v.name + " but I'm straight unlike you!"; }
	else if (t == 10) { return a.name + ": i'm so lazy I set explosives that dumb people like " + v.name + " detonate!"; }
	else if (t == 11) { return a.name + ": hey " + v.name + " your brains are missing!"; }
	else if (t == 12) { return a.name + ": hey " + v.name + " you're dead again!"; }
}