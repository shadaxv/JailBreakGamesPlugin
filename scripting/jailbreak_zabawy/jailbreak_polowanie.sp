bool polowanieZaczeta=false;
new timer1=60;
new Handle:handlel1=INVALID_HANDLE;
new Handle:handlepol1=INVALID_HANDLE;
new Handle:handlepol2=INVALID_HANDLE;

public Action:StartPolowania(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Polowanie</font>!\n\n<font color='#009900'>CT ZOSTAJA W GR!</font>");
	handlepol1=CreateTimer(65.0,PolowaniePrzygotuj);
	handlepol2=CreateTimer(4.0,PrzygotujLicznikPolowania);
	PrintToChatAll("\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 1. Wiezniowie rozbiegaja sie po mapie, Straznicy zostaja w GR.");
	PrintToChatAll("\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 2. Po minucie Straznicy wybiegaja z GR. Straznicy zabijaja tylko z AWP, Wiezniowie tylko z noza.");
	PrintToChatAll("\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 3. Zakaz kampienia w Medyku, w bezposrednim otoczeniu GR oraz przy Teleportach.");
	PrintToChatAll("\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 4. Jesli Wiezien wejdzie do GR przed wyjsciem Straznikow, moze zostac zabity z dowolnej broni.");
	PrintToChatAll("\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(i, SDKHook_TraceAttack, TraceAttack);
		}
	}
}
public Action:PrzygotujLicznikPolowania(Handle:timer)
{
	handlel1=CreateTimer(1.0,WyswietlLicznikPolowania,_,TIMER_REPEAT);
	handlepol2=INVALID_HANDLE;
}
public Action:WyswietlLicznikPolowania(Handle:timer)
{
	if(timer1>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'>    Polowanie</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer1);
	timer1--;
	} else
	{
		KillTimer(handlel1);
		handlel1=INVALID_HANDLE;
		timer1=60;
	}
}
public Action:PolowaniePrzygotuj(Handle:timer)
{
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			SetEntProp(i, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(i,"weapon_knife",true);
			if(GetClientTeam(i)==CS_TEAM_CT)
				GivePlayerItem(i,"weapon_awp");
			SDKHook(i, SDKHook_WeaponCanUse, OnWeaponCanUse);
		}
	}
	polowanieZaczeta=true;
	PrintHintTextToAll("CT wychodza z GR, zabawa sie zaczela!\n<font color='#009900'>Powodzenia! ;)</font>");
	ServerCommand("sv_infinite_ammo 2");
	handlepol1=INVALID_HANDLE;
}
public Action:Command_Drop(iClient,const String:sCommand[],iArgs)
{
	if(wlaczona==true && numerZabawy==1 && polowanieZaczeta==true && GetClientTeam(iClient)==CS_TEAM_CT)
	{
		return Plugin_Handled;
	} else return Plugin_Continue;
}