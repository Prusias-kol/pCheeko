
// build/use BALLS macros

//combine/append
string c2t_bb(string m,string s) {
	return m + s;
}
//just in case
string c2t_bb(string m) {
	return m;
}

//finite repetition of a skill
string c2t_bb(int num,skill ski) {
	string out;
	for (int i = 0;num > i;i++)
		out += `if hasskill {ski.to_int()};skill {ski.to_int()};endif;`;
	return out;
}
string c2t_bb(string m,int num,skill ski) {
	return m + c2t_bb(num,ski);
}
//single skill
string c2t_bb(skill ski) {
	return c2t_bb(1,ski);
}
string c2t_bb(string m,skill ski) {
	return m + c2t_bb(1,ski);
}

//combat item(s)
string c2t_bb(item it1) {
	if (item_amount(it1) == 0)
		return "";
	return `use {it1.to_int()};`;
}
string c2t_bb(string m,item it1) {
	return m + c2t_bb(it1);
}
//funkslinging
string c2t_bb(item it1,item it2) {
	if (item_amount(it1) == 0)
		return c2t_bb(it2);
	if (item_amount(it2) == 0)
		return c2t_bb(it1);
	return `use {it1.to_int()},{it2.to_int()};`;
}
string c2t_bb(string m,item it1,item it2) {
	return m + c2t_bb(it1,it2);
}

//if
string c2t_bbIf(string c,string s) {
	return `if {c};{s}endif;`;
}
string c2t_bbIf(string m,string c,string s) {
	return m + c2t_bbIf(c,s);
}

//while
string c2t_bbWhile(string c,string s) {
	return `while {c};{s}endwhile;`;
}
string c2t_bbWhile(string m,string c,string s) {
	return m + c2t_bbWhile(c,s);
}

//submit
string c2t_bbSubmit(string m) {
	string out = visit_url("fight.php?action=macro&macrotext="+m,true,false);
	return out;
}
void main(int initround, monster foe, string page) {
    string mHead = "scrollwhendone;";
	string mSteal = "pickpocket;";

	//top of basic macro, where all the weakening stuff is
	string mBasicTop =
		c2t_bb($skill[Emit Matter Duplicating Drones])
        .c2t_bb($skill[curse of weaksauce])
		.c2t_bb($skill[disarming thrust])
		.c2t_bb($skill[micrometeorite])
		.c2t_bb($skill[detect weakness]);

	//bottom of basic macro, where all the damaging stuff is
	string mBasicBot =
		c2t_bbIf("sealclubber || turtletamer || discobandit || accordionthief",
			c2t_bb($skill[sing along])
			.c2t_bbWhile("!pastround 20",c2t_bb("attack;"))
		)
		.c2t_bbIf("pastamancer",
			c2t_bb($skill[stuffed mortar shell])
			.c2t_bb($skill[sing along])
			.c2t_bb($skill[saucegeyser])
		)
		.c2t_bbIf("sauceror",
			c2t_bb($skill[stuffed mortar shell])
			.c2t_bb($skill[sing along])
			.c2t_bb($skill[saucegeyser])
		);

	//basic macro/what to run when nothing special needs be done
	string mBasic =	mBasicTop + mBasicBot;
    string m = "";

    switch (foe) {
        case $monster[rushing bum]:
            c2t_bbSubmit(mBasic);
            break;
        case $monster[big creepy spider]:
            c2t_bbSubmit(c2t_bb($item[ice house]));
            break;
        case $monster[completely different spider]:
            c2t_bbSubmit(c2t_bb($item[tryptophan dart]));
            break;
        case $monster[drunken half-orc hobo]:
            c2t_bbSubmit(c2t_bb($item[human musk]));
            break;    
        case $monster[hung-over half-orc hobo]:
            c2t_bbSubmit(c2t_bb($skill[Bowl a Curveball]));
            break;
        default:
            c2t_bbSubmit(mBasic);
    }
}