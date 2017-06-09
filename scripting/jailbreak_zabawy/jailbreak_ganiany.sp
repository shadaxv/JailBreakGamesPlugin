new timer3=30;
new Handle:handlel3=INVALID_HANDLE;
new Handle:handlegn1=INVALID_HANDLE;
new Handle:handlegn2=INVALID_HANDLE;

public Action:StartGanianego(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Ganianego</font>!\n\n<font color='#009900'>CT otwieraja cele i zostaja w GR!</font>");
	handlegn1=CreateTimer(35.0,GanianyPoczatek);
	handlegn2=CreateTimer(4.0,PrzygotujLicznikGanianego);
	PrintToChatAll("\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 1. Przez pierwsze 30 sekund zabawy Straznicy maja zakaz wychodzenia z GR, a Wiezniowie rozbiegaja sie po mapie.");
	PrintToChatAll("\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 2. Po tym czasie Straznicy wybiegaja z GR i probuja zabic Wiezniow przy uzyciu noza.");
	PrintToChatAll("\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 3. Zarowno Straznicy jak i Wiezniowie maja zablokowana mozliwosc podnoszenia broni palnej.");
	PrintToChatAll("\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 4. Wiezniowie maja zakaz kampienia w jednym miejscu - musza biegac po mapie!");
	PrintToChatAll("\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 5. Ostatni wiezien MA ZYCZENIE.");
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			if(GetClientTeam(i)==CS_TEAM_CT)
			{
				SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
				SDKHook(i, SDKHook_TraceAttack, TraceAttack);
				SDKHook(i, SDKHook_WeaponCanUse, OnWeaponCanUse);
			} else
			if(GetClientTeam(i)==CS_TEAM_T)
			{
				SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue",1.6);
				SDKHook(i, SDKHook_WeaponCanUse, OnWeaponCanUse);
			}
			SetEntProp(i, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(i,"weapon_knife",true);
		}
	}
}
public Action:PrzygotujLicznikGanianego(Handle:timer)
{
	handlel3=CreateTimer(1.0,WyswietlLicznikGanianego,_,TIMER_REPEAT);
	handlegn2=INVALID_HANDLE;
}
public Action:WyswietlLicznikGanianego(Handle:timer)
{
	if(timer3>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'>     Ganiany</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer3);
	timer3--;
	} else
	{
		KillTimer(handlel3);
		handlel3=INVALID_HANDLE;
		timer3=30;
	}
}
public Action:GanianyPoczatek(Handle:timer)
{
	PrintHintTextToAll("Straznicy zaczynaja gonic Wiezniow.\n\n<font color='#009900'>Powodzenia! ;)</font>");
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			if(GetClientTeam(i)==CS_TEAM_CT)
			{
				SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue",1.65); 
			}
			if(GetClientTeam(i)==CS_TEAM_T)
			{
				SetEntProp(i,Prop_Send,"m_iHideHUD",GetEntProp(i,Prop_Send,"m_iHideHUD")^1<<12);
			}
		}
	}
	handlegn1=INVALID_HANDLE;
}