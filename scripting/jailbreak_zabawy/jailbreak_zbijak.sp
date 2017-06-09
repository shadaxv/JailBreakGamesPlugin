bool zbijakZaczety=false;
new timer6=30;
new Handle:handlel6=INVALID_HANDLE;
new Handle:handlez1=INVALID_HANDLE;
new Handle:handlez2=INVALID_HANDLE;

public Action:StartZbijaka(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Zbijaka</font>!\n\n<font color='#009900'>CT otwieraja cele, zajmijcie pozycje!</font>");
	handlez1=CreateTimer(35.0,ZbijakPoczatek,_,TIMER_FLAG_NO_MAPCHANGE);
	handlez2=CreateTimer(4.0,PrzygotujLicznikZbijaka,_,TIMER_FLAG_NO_MAPCHANGE);
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 1. Przez pierwsze 30 sekund wszyscy gracze rozbiegaja sie po mapie.");
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 2. Po tym czasie kazdy otrzymuje Decoya, ktorym stara sie trafic przeciwnika.");
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 3. Trafienie wroga granatem oznacza jego natychmiastowa smierc.");
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 4. Zabawa trwa do ostatniej zywej osoby - jest to zabawa DLA WSZYSTKICH.");
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 5. Mozna tworzyc maksymalnie trzyosobowe sojusze.");
	PrintToChatAll("\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 6. Ostatni wiezien NIE MA zyczenia.");
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(i, SDKHook_WeaponCanUse, OnWeaponCanUse);
			SDKHook(i, SDKHook_TraceAttack, TraceAttack);
			SetEntProp(i, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(i,"weapon_knife",true);
		}
	}
}
public Action:PrzygotujLicznikZbijaka(Handle:timer)
{
	handlel6=CreateTimer(1.0,WyswietlLicznikZbijaka,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	handlez2=INVALID_HANDLE;
}
public Action:WyswietlLicznikZbijaka(Handle:timer)
{
	if(timer6>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'>       Zbijak</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer6);
	timer6--;
	} else
	{
		KillTimer(handlel6);
		handlel6=INVALID_HANDLE;
		timer6=30;
	}
}
public Action:ZbijakPoczatek(Handle:timer)
{
	PrintHintTextToAll("Zabawa sie zaczela, dostajecie granaty!\n<font color='#009900'>Powodzenia! ;)</font>");
	ServerCommand("mp_ignore_round_win_conditions 1");
	ServerCommand("mp_teammates_are_enemies 1");
	ServerCommand("sv_infinite_ammo 1");
	ServerCommand("sv_ignoregrenaderadio 1");
	zbijakZaczety=true;
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			GivePlayerItem(i, "weapon_decoy");
			SetEntProp(i, Prop_Send, "m_iHideHUD", GetEntProp(i, Prop_Send, "m_iHideHUD") ^ 1<<12);
		}
	}			
	handlez1=INVALID_HANDLE;
}
public Action:Event_DecoyStarted(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(numerZabawy==6 && zbijakZaczety==true)
	{
		new entityid = (GetEventInt(event, "entityid"));
		if(IsValidEntity(entityid))
		{
				AcceptEntityInput(entityid, "kill");
		}
	}
}