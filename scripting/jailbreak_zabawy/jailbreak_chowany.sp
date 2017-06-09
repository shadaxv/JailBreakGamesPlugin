new timer4=60;
new Handle:handlel4=INVALID_HANDLE;
new Handle:handlech1=INVALID_HANDLE;
new Handle:handlech2=INVALID_HANDLE;
new FogIndex = -1;
new Float:mapFogStart = 0.0;
new Float:mapFogEnd = 275.0;
new Float:mapFogDensity = 1.0;


new FroggyJumped[MAXPLAYERS + 1];
new bool:FroggyJump[MAXPLAYERS + 1];

public Action:StartChowanego(client)
{
	PrintHintTextToAll("Dzis bawimy sie w <font color='#FF0000'>Chowanego</font>!\n\n<font color='#009900'>CT otwieraja cele i zostaja w GR!</font>");
	handlech1=CreateTimer(65.0,ChowanyPoczatek);
	handlech2=CreateTimer(4.0,PrzygotujLicznikChowanego);
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 1. Przez pierwsze 60 sekund Straznicy maja zakaz opuszczania GR.");
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 2. W tym czasie Wiezniowie rozbiegaja sie po mapie w poszukiwaniu kryjowki, po minucie robi sie ciemno.");
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 3. Wiezniowie maja kategoryczny zakaz chowania sie poza teksturami mapy.");	
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 4. Po wyznaczonym czasie Wiezniowie maja bezruch, a Straznicy probuja ich znalezc.");
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 5. Gdy Straznik znajdzie Wieznia, musi go zabic.");
	PrintToChatAll("\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 6. Ostatni wiezien MA ZYCZENIE.");
	ServerCommand("sv_gravity 300");
	for(new i=1; i <= GetMaxClients(); i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			if(GetClientTeam(i)==CS_TEAM_CT)
			{
				SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
				SDKHook(i, SDKHook_TraceAttack, TraceAttack);
			} else
			if(GetClientTeam(i)==CS_TEAM_T)
			{
				SetEntProp(i, Prop_Data, "m_iFOV", 0);
				Client_RemoveAllWeapons(i,"weapon_knife",true);
				SDKHook(i, SDKHook_WeaponCanUse, OnWeaponCanUse);
			}
		}
	}
}
public Action:PrzygotujLicznikChowanego(Handle:timer)
{
	handlel4=CreateTimer(1.0,WyswietlLicznikChowanego,_,TIMER_REPEAT);
	handlech2=INVALID_HANDLE;
}
public Action:WyswietlLicznikChowanego(Handle:timer)
{
	if(timer4>0)
	{
	PrintHintTextToAll("<font size='40' color='#009900'>     Chowany</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund",timer4);
	timer4--;
	} else
	{
		KillTimer(handlel4);
		handlel4=INVALID_HANDLE;
		timer4=60;
	}
}
public Action:ChowanyPoczatek(Handle:timer)
{
	PrintHintTextToAll("Straznicy zaczynaja szukac Wiezniow.\n\n<font color='#009900'>Powodzenia! ;)</font>");
	fogon();
	ServerCommand("sv_infinite_ammo 2");
	for(new i=1;i<=GetMaxClients();i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
		{
			SetEntityFlags(i, GetEntityFlags(i)^FL_ATCONTROLS);
			SetEntProp(i,Prop_Send,"m_iHideHUD",GetEntProp(i,Prop_Send,"m_iHideHUD")^1<<12);
		}
		else if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_CT)
		{
			SetEntProp(i,Prop_Send,"m_iHideHUD",GetEntProp(i,Prop_Send,"m_iHideHUD")^1<<12);
		}
	}
	handlech1=INVALID_HANDLE;
	chowanyStart = 1;
}
public Action:fogoff()
{AcceptEntityInput(FogIndex, "TurnOff");}

public Action:fogon()
{AcceptEntityInput(FogIndex, "TurnOn");}

DoFog()
{
    if(FogIndex != -1) 
    {
        DispatchKeyValue(FogIndex, "fogblend", "0");
        DispatchKeyValue(FogIndex, "fogcolor", "0 0 0");
        DispatchKeyValue(FogIndex, "fogcolor2", "0 0 0");
        DispatchKeyValueFloat(FogIndex, "fogstart", mapFogStart);
        DispatchKeyValueFloat(FogIndex, "fogend", mapFogEnd);
        DispatchKeyValueFloat(FogIndex, "fogmaxdensity", mapFogDensity);
    }
}

public Action:OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon)
{
	if(chowanyStart == 1)
	{
		if(IsClientInGame(client) && IsPlayerAlive(client) && GetClientTeam(client)==CS_TEAM_T)
		{
			//SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 0.0);
			if(!(GetEntityFlags(client) & FL_ATCONTROLS))
				SetEntityFlags(client, GetEntityFlags(client)^FL_ATCONTROLS);
			//SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		}
	}
	
	if (!IsClientInGame(client) || !IsPlayerAlive(client) || !FroggyJump[client])
		return Plugin_Continue;
	
	static bool:bPressed[MAXPLAYERS+1] = false;

	if(GetEntityFlags(client) & FL_ONGROUND)
	{
		FroggyJumped[client] = 0;
		bPressed[client] = false;
	}
	else
	{
		if (buttons & IN_JUMP)
		{
			if(!bPressed[client])
			{
				if(FroggyJumped[client]++ == 1)
					froggyjump(client);
			}

			bPressed[client] = true;
		}
		else
			bPressed[client] = false;
	}

	
	return Plugin_Continue;
}