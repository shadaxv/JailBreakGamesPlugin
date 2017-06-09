new timer5=60;
new Handle:handlel5=INVALID_HANDLE;
new Handle:handlewg1=INVALID_HANDLE;
new Handle:handlewg2=INVALID_HANDLE;
new Handle:handlewg3=INVALID_HANDLE;
new user_gangi[65];
char kolor[][] = {"Czerwony", "Zielony", "Niebieski", "Zolty", "Fioletowy"};
char kolor2[][] = {"\x07Czerwony\x01","\x04Zielony\x01","\x0CNiebieski\x01","\x09Zolty\x01","\x03Fioletowy\x01"};
new kolor_gang[][5] = {
	{204,0,0},	//czerwony
	{0,204,0},	//zielony
	{0,102,255},	//niebieski
	{255, 204, 0}, //zolty
	{102, 0, 102} //fioletowy
};
static przydzial = 0;
new iCountwg = 0;
new zliczaj = 0;
new licznikGangow[5]={0,0,0,0,0};
bool JedenGang=false;
bool JedenGangInfo=false;

public Action:StartWojenGangow(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Wojny Gangow</font>!\n\n<font color='#009900'>CT otwieraja cele!</font>");
	handlewg1=CreateTimer(10.0,WojnyGangowPokazMenu);
	handlewg2=CreateTimer(65.0,WojnyGangowPrzygotuj);
	handlewg3=CreateTimer(4.0,PrzygotujLicznikWG);
	PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 1. Wiezniowie zostaja podzieleni na trzy druzyny: Niebieska, Zielona i Czerwona.");
	PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 2. Po minucie zostaje wlaczony box, a druzyny walcza miedzy soba.");
	PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 3. Gdy przy zyciu zostanie tylko jedna druzyna, jej czlonkowie walcza miedzy soba.");
	PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 4. Zakaz kampienia w GR oraz Medyku.");
	PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 5. Ostatni wiezien MA ZYCZENIE.");
	iCountwg = 0;
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(i, SDKHook_TraceAttack, TraceAttack);
		}
		
		if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
		{
				iCountwg++;
		}
	}
}
public Action:PrzygotujLicznikWG(Handle:timer)
{
	handlel5=CreateTimer(1.0,WyswietlLicznikWG,_,TIMER_REPEAT);
	handlewg3=INVALID_HANDLE;
}
public Action:WyswietlLicznikWG(Handle:timer)
{
	if(timer5>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'> Wojny Gangow</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer5);
	timer5--;
	} else
	{
		KillTimer(handlel5);
		handlel5=INVALID_HANDLE;
		timer5=60;
	}
}
public Action:WojnyGangowPrzygotuj(Handle:timer)
{
	ServerCommand("mp_teammates_are_enemies 1");
	PrintHintTextToAll("Box zostal wlaczony.\n\n<font color='#009900'>Powodzenia! ;)</font>");
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
		{
			SetEntProp(i,Prop_Send,"m_iHideHUD",GetEntProp(i,Prop_Send,"m_iHideHUD")^1<<12);
		}
	}
	handlewg2=INVALID_HANDLE;
}
public Action:WojnyGangowPokazMenu(Handle:timer)
{

	if(iCountwg <= 6)
	{
		zliczaj = 2;
	}
	
	else if(iCountwg > 6 && iCountwg <= 15)
	{
		zliczaj = 3;
	}
	
	else if(iCountwg > 15 && iCountwg <= 24)
	{
		zliczaj = 4;
	}
	
	else if(iCountwg >= 25)
	{
		zliczaj = 5;
	}
	
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
		{
			SetEntProp(i, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(i,"weapon_knife",true);
			UstawPrzydzial(i);
			WojnyGangowMenu1(i);
			GivePlayerItem(i, "item_assaultsuit");
			SetEntProp(i,Prop_Send,"m_ArmorValue",100,1);
			GivePlayerItem(i,"weapon_hegrenade");
			if(GetUserFlagBits(i) & ADMFLAG_CUSTOM6)
			{
				GivePlayerItem(i,"weapon_flashbang");
				GivePlayerItem(i,"weapon_smokegrenade");
				GivePlayerItem(i, "item_heavyassaultsuit");
				SetEntProp(i,Prop_Send,"m_ArmorValue",200,1);
			}
		}
	}
	
	if(iCountwg <= 6)
	{
		PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x07Czerwony: %d\x01, \x04Zielony: %d\x01.",licznikGangow[0],licznikGangow[1]);
	}
	
	else if(iCountwg > 6 && iCountwg <= 15)
	{
		PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x07Czerwony: %d\x01, \x04Zielony: %d\x01, \x0CNiebieski: %d\x01.",licznikGangow[0],licznikGangow[1],licznikGangow[2]);
	}
	
	else if(iCountwg > 15 && iCountwg <= 24)
	{
		PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x07Czerwony: %d\x01, \x04Zielony: %d\x01, \x0CNiebieski: %d\x01, \x09Zolty: %d\x01.",licznikGangow[0],licznikGangow[1],licznikGangow[2],licznikGangow[3]);
	}
	
	else if(iCountwg >= 25)
	{
		PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x07Czerwony: %d\x01, \x04Zielony: %d\x01, \x0CNiebieski: %d\x01, \x09Zolty: %d\x01, \x03Fioletowy: %d\x01.",licznikGangow[0],licznikGangow[1],licznikGangow[2],licznikGangow[3],licznikGangow[4]);
	}
	
	przydzial=0;
	handlewg1=INVALID_HANDLE;
}
public UstawPrzydzial(id)
{
	if(IsClientInGame(id) && IsPlayerAlive(id))
	{
		user_gangi[id] = przydzial;
		SetEntityRenderColor(id,kolor_gang[przydzial][0],kolor_gang[przydzial][1],kolor_gang[przydzial][2],255);
		PrintToChat(id,"\x01[\x04Zabawy - Wojny Gangow\x01] Twoj kolor to: %s.",kolor2[przydzial]);
		licznikGangow[przydzial]++
		if(++przydzial >= zliczaj)
			przydzial = 0;
	}
}
public Action:WojnyGangowMenu1(client)
{
	decl String:druzyna[32];
	Format(druzyna, sizeof(druzyna), "AWP\nTWOJ KOLOR: %s", kolor[user_gangi[client]]);
	new Handle:wgmenu1 = CreateMenu(WojnyGangowMenuHandler1, MENU_ACTIONS_ALL);
	SetMenuTitle(wgmenu1, "Wybierz bron dluga:");
	AddMenuItem(wgmenu1, "#choice1", "AK-47");
	AddMenuItem(wgmenu1, "#choice2", "M4A1-S");
	AddMenuItem(wgmenu1, "#choice3", "M4A4");
	AddMenuItem(wgmenu1, "#choice4", "P90");
	AddMenuItem(wgmenu1, "#choice5", "XM1014");
	AddMenuItem(wgmenu1, "#choice6", druzyna);
	SetMenuExitButton(wgmenu1, true);
	DisplayMenu(wgmenu1, client, 60);
	return Plugin_Handled;
}
public WojnyGangowMenuHandler1(Handle:wgmenu1, MenuAction:action, param1, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			decl String:info[32];
			GetMenuItem(wgmenu1, param2, info, sizeof(info));
			if (StrEqual(info,"#choice1"))
			{
				GivePlayerItem(param1,"weapon_ak47");
				WojnyGangowMenu2(param1);
			} else if(StrEqual(info,"#choice2"))
			{
				GivePlayerItem(param1,"weapon_m4a1_silencer");
				WojnyGangowMenu2(param1);
			} else if(StrEqual(info,"#choice3"))
			{
				GivePlayerItem(param1,"weapon_m4a1");
				WojnyGangowMenu2(param1);
			} else if(StrEqual(info,"#choice4"))
			{
				GivePlayerItem(param1,"weapon_p90");
				WojnyGangowMenu2(param1);
			} else if(StrEqual(info,"#choice5"))
			{
				GivePlayerItem(param1,"weapon_xm1014");
				WojnyGangowMenu2(param1);
			} else if(StrEqual(info,"#choice6"))
			{
				GivePlayerItem(param1,"weapon_awp");
				WojnyGangowMenu2(param1);
			}
		}
		case MenuAction_End:
		{
			CloseHandle(wgmenu1);
		} 
	}
	return 0;
}
public Action:WojnyGangowMenu2(client)
{
	decl String:druzyna[32];
	Format(druzyna, sizeof(druzyna), "FiveSeven\nTWOJ KOLOR: %s", kolor[user_gangi[client]]);
	new Handle:wgmenu2 = CreateMenu(WojnyGangowMenuHandler2, MENU_ACTIONS_ALL);
	SetMenuTitle(wgmenu2, "Wybierz bron krotka:");
	AddMenuItem(wgmenu2, "#choice1", "Glock");
	AddMenuItem(wgmenu2, "#choice2", "P2000");
	AddMenuItem(wgmenu2, "#choice3", "USP");
	AddMenuItem(wgmenu2, "#choice4", "Deagle");
	AddMenuItem(wgmenu2, "#choice5", "Tec9");
	AddMenuItem(wgmenu2, "#choice6", druzyna);
	SetMenuExitButton(wgmenu2, true);
	DisplayMenu(wgmenu2, client, 60);
	return Plugin_Handled;
}
public WojnyGangowMenuHandler2(Handle:wgmenu2, MenuAction:action, param1, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			decl String:info[32];
			GetMenuItem(wgmenu2, param2, info, sizeof(info));
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
			CloseHandle(wgmenu2);
		} 
	}
	return 0;
}
public Action:WGKolor(client,args)
{
	if(wlaczona==true && numerZabawy==5)
	{
		if(IsPlayerAlive(client) && GetClientTeam(client)==CS_TEAM_T && handlewg1==INVALID_HANDLE)
		{
			PrintToChat(client,"\x01[\x04Zabawy - Wojny GangowJ\x01] Twoj kolor to: %s.",kolor2[user_gangi[client]]);
		}
	}
}
public Action:SprawdzDruzyny(any:client)
{
	new p=GetRandomInt(0,2);
	user_gangi[client] = p;
	SetEntityRenderColor(client,kolor_gang[p][0],kolor_gang[p][1],kolor_gang[p][2],255);
	PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] Twoj kolor to: %s.",kolor2[p]);
}