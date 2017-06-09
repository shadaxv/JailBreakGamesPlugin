new timer2=60;
new Handle:handlel2=INVALID_HANDLE;
new Handle:handlekd1=INVALID_HANDLE;
new Handle:handlekd2=INVALID_HANDLE;
new Handle:handlekd3=INVALID_HANDLE;

public Action:StartKilldaya(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Killday</font>!\n\n<font color='#009900'>CT otwieraja cele!</font>");
	handlekd1=CreateTimer(10.0,KilldayPokazMenu,_,TIMER_FLAG_NO_MAPCHANGE);
	handlekd2=CreateTimer(65.0,KilldayPrzygotuj,_,TIMER_FLAG_NO_MAPCHANGE);
	handlekd3=CreateTimer(4.0,PrzygotujLicznikKilldaya,_,TIMER_FLAG_NO_MAPCHANGE);
	PrintToChatAll("\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 1. Gracze rozbiegaja sie po mapie, po minucie zostaje wlaczony box.");
	PrintToChatAll("\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 2. CT walcza miedzy CT, TT walczy miedzy TT. Gdy przy zyciu zostanie po jednym graczu z druzyny, walcza miedzy soba.");
	PrintToChatAll("\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 3. Zakaz kampienia w Medyku oraz GR.");
	PrintToChatAll("\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 4. Mozna tworzyc maksymalnie trzyosobowe sojusze.");
	PrintToChatAll("\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(i, SDKHook_TraceAttack, TraceAttack);
		}
	}
}
public Action:PrzygotujLicznikKilldaya(Handle:timer)
{
	handlel2=CreateTimer(1.0,WyswietlLicznikKilldaya,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	handlekd3=INVALID_HANDLE;
}
public Action:WyswietlLicznikKilldaya(Handle:timer)
{
	if(timer2>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'>      Killday</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer2);
	timer2--;
	} else
	{
		KillTimer(handlel2);
		handlel2=INVALID_HANDLE;
		timer2=60;
	}
}
public Action:KilldayPrzygotuj(Handle:timer)
{
	ServerCommand("mp_ignore_round_win_conditions 1");
	ServerCommand("mp_teammates_are_enemies 1");
	PrintHintTextToAll("Box zostal wlaczony.\n\n<font color='#009900'>Powodzenia! ;)</font>");
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && (GetClientTeam(i)==CS_TEAM_T || GetClientTeam(i)==CS_TEAM_CT))
		{
			SetEntProp(i,Prop_Send,"m_iHideHUD",GetEntProp(i,Prop_Send,"m_iHideHUD")^1<<12);
		}
	}
	handlekd2=INVALID_HANDLE;
	
}
public Action:KilldayPokazMenu(Handle:timer)
{
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && (GetClientTeam(i)==CS_TEAM_T || GetClientTeam(i)==CS_TEAM_CT))
		{
			SetEntProp(i, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(i,"weapon_knife",true);
			KilldayMenu1(i);
			GivePlayerItem(i, "item_assaultsuit");
			SetEntProp(i,Prop_Send,"m_ArmorValue",100,1);
			GivePlayerItem(i,"weapon_hegrenade");
			if(GetUserFlagBits(i) & ADMFLAG_CUSTOM6)
			{
				GivePlayerItem(i,"weapon_flashbang");
				GivePlayerItem(i,"weapon_smokegrenade");
			}
		}
	}
	handlekd1=INVALID_HANDLE;
}
public Action:KilldayMenu1(client)
{
	new Handle:kdmenu1 = CreateMenu(KilldayMenuHandler1, MENU_ACTIONS_ALL);
	SetMenuTitle(kdmenu1, "Wybierz bron dluga:");
	AddMenuItem(kdmenu1, "#choice1", "AK-47");
	AddMenuItem(kdmenu1, "#choice2", "M4A1-S");
	AddMenuItem(kdmenu1, "#choice3", "M4A4");
	AddMenuItem(kdmenu1, "#choice4", "P90");
	AddMenuItem(kdmenu1, "#choice5", "XM1014");
	AddMenuItem(kdmenu1, "#choice6", "AWP");
	SetMenuExitButton(kdmenu1, true);
	DisplayMenu(kdmenu1, client, 60);
	return Plugin_Handled;
}
public KilldayMenuHandler1(Handle:kdmenu1, MenuAction:action, param1, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			decl String:info[32];
			GetMenuItem(kdmenu1, param2, info, sizeof(info));
			if (StrEqual(info,"#choice1"))
			{
				GivePlayerItem(param1,"weapon_ak47");
				KilldayMenu2(param1);
			} else if(StrEqual(info,"#choice2"))
			{
				GivePlayerItem(param1,"weapon_m4a1_silencer");
				KilldayMenu2(param1);
			} else if(StrEqual(info,"#choice3"))
			{
				GivePlayerItem(param1,"weapon_m4a1");
				KilldayMenu2(param1);
			} else if(StrEqual(info,"#choice4"))
			{
				GivePlayerItem(param1,"weapon_p90");
				KilldayMenu2(param1);
			} else if(StrEqual(info,"#choice5"))
			{
				GivePlayerItem(param1,"weapon_xm1014");
				KilldayMenu2(param1);
			} else if(StrEqual(info,"#choice6"))
			{
				GivePlayerItem(param1,"weapon_awp");
				KilldayMenu2(param1);
			}
		}
		case MenuAction_End:
		{
			CloseHandle(kdmenu1);
		} 
	}
	return 0;
}
public Action:KilldayMenu2(client)
{
	new Handle:kdmenu2 = CreateMenu(KilldayMenuHandler2, MENU_ACTIONS_ALL);
	SetMenuTitle(kdmenu2, "Wybierz bron krotka:");
	AddMenuItem(kdmenu2, "#choice1", "Glock");
	AddMenuItem(kdmenu2, "#choice2", "P2000");
	AddMenuItem(kdmenu2, "#choice3", "USP");
	AddMenuItem(kdmenu2, "#choice4", "Deagle");
	AddMenuItem(kdmenu2, "#choice5", "Tec9");
	AddMenuItem(kdmenu2, "#choice6", "FiveSeven");
	SetMenuExitButton(kdmenu2, true);
	DisplayMenu(kdmenu2, client, 60);
	return Plugin_Handled;
}
public KilldayMenuHandler2(Handle:kdmenu2, MenuAction:action, param1, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			decl String:info[32];
			GetMenuItem(kdmenu2, param2, info, sizeof(info));
			if (StrEqual(info,"#choice1"))
			{
				GivePlayerItem(param1,"weapon_glock");
			} else if(StrEqual(info,"#choice2"))
			{
				GivePlayerItem(param1,"weapon_hkp2000");
			} else if(StrEqual(info,"#choice3"))
			{
				GivePlayerItem(param1,"weapon_usp_silencer");
			} else if(StrEqual(info,"#choice4"))
			{
				GivePlayerItem(param1,"weapon_deagle");
			} else if(StrEqual(info,"#choice5"))
			{
				GivePlayerItem(param1,"weapon_tec9");
			} else if(StrEqual(info,"#choice6"))
			{
				GivePlayerItem(param1,"weapon_fiveseven");
			}
		}
		case MenuAction_End:
		{
			CloseHandle(kdmenu2);
		} 
	}
	return 0;
}