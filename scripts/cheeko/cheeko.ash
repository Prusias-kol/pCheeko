script "cheeko";
notify Coolfood;

void cheeko(int x) {
    int size = my_adventures();
    if (size == 0 || x == 0) {
        print("Either asked for 0 advs or no advs left.", "red");
        return;
    }
    // if (item_amount($item[9760]) == 1) {
    //     cli_execute("garden pick");
    //     use(1, $item[9760]); //install pokegrow
    // }
    if (x == -1) {
        x = size;
    } else if (x > size) {
        print("Only " + size + " advs left. Using all of them. ", "blue");
        x = size;
    }
    print("Preparing CHEEKO", "blue");
    string prevCombat = get_property('customCombatScript');
    set_property('customCombatScript',"cheeko");
    use_familiar($familiar[Grey Goose]);
    equip($slot[acc1], $item[teacher's pen]);
    equip($slot[acc2], $item[teacher's pen]);
    maximize("+combat,0.1 item,-equip broken champagne bottle,1000 bonus tiny stillsuit, 900 bonus grey down vest, -acc1, -acc2", false);
    cli_execute("acquire 1 tryptophan dart");
    cli_execute("acquire 1 ice house");
    cli_execute("acquire 1 human musk");
    print("starting CHEEKO", "blue");
    for (int i = 0; i < x; i++) {
        adv1($location[The Sleazy Back Alley],-1,"");
    }
    set_property('customCombatScript',prevCombat);

}

void main(string option) {
    string [int] commands = option.split_string("\\s+");
    if(commands.count() != 0)
    {
        if (commands[0] == "*") {
            cheeko(-1);
        } else {
            int conversions = commands[0].to_int();
            cheeko(conversions);
        }
    }
    else
    {
        print("cheeko requires an argument: The number of advs to spend. * for all", "red");
        return;
    }

}