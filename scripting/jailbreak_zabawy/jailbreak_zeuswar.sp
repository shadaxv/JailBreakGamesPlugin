new startZeus = 0;
new koniecZeus = 0;

new checkZeus = 0;

new numPrinted3 = 30;

new Handle:MyZeusOdliczanie=INVALID_HANDLE;
new Handle:MyGiveZeus2;
new Handle:handlezeus=INVALID_HANDLE;

public Action:ZeusStart(client)
{

	PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 1. Po rozpoczeciu zabawy, gracze maja 30 sekund na rozbiegniecie sie po mapie.");
	//PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 2. P\x01o \x02t\x03y\x04m \x05c\x06z\x07a\x08s\x09i\x10e \x0Bk\x0Ca\x0Ezdy otrzymuje Zeusa i stara sie zabic przeciwnikow.");
	PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 2. Po tym czasie kazdy otrzymuje Zeusa i stara sie zabic przeciwnikow.");
	PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 3. Kazdy z graczy otrzymuje wieksza predkosc, mniejsza grawitacje oraz dodatkowe HP.");
	PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 4. Zabawa trwa do ostatniej zywej osoby - jest to zabawa DLA WSZYSTKICH.");
	PrintToChatAll("\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	
	startZeus = 1;
	koniecZeus = 0;
	numPrinted3 = 30;
	checkZeus = 0;
	
	MyZeusOdliczanie = CreateTimer(1.0, ZeusOdliczanie, _, TIMER_REPEAT); //Odliczanie do startu zabawy
	
	decl maxent;
	new String:weapon[64];
	maxent = GetMaxEntities();
	for (new iZeus=0; iZeus<=maxent; iZeus++)
	{

		if (IsValidEdict(iZeus) && IsValidEntity(iZeus))
		{
			GetEdictClassname(iZeus, weapon, sizeof(weapon));
			if (StrContains(weapon, "weapon_") != -1 && StrContains(weapon, "weapon_knife") == -1)
			{
				RemoveEdict(iZeus);
			}
		}
	}
	
	for(new i2Zeus=1; i2Zeus <= GetMaxClients(); i2Zeus++)
	{
		if(IsClientInGame(i2Zeus) && IsPlayerAlive(i2Zeus))
		{
			SetEntProp(i2Zeus,Prop_Send,"m_iHideHUD",GetEntProp(i2Zeus,Prop_Send,"m_iHideHUD")^1<<12);
			SDKHook(i2Zeus, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(i2Zeus, SDKHook_TraceAttack, TraceAttack);
			SDKHook(i2Zeus, SDKHook_WeaponCanUse, OnWeaponCanUse);
		}
	}
		
	handlezeus=CreateTimer(30.0,ZeusAnuluj);

}

public Action:ZeusAnuluj(Handle:timer)
{
	handlezeus=INVALID_HANDLE;
}

public Action:ZeusOdliczanie(Handle:timer)
{
	if(koniecZeus == 1)
	{
		MyZeusOdliczanie = INVALID_HANDLE;
		return Plugin_Stop;
	}
	
	else if(startZeus == 1)
	{
		if (numPrinted3 <= 0)
		{
			PrintHintTextToAll("Zabawa sie zaczela!\n<font color='#009900'>Powodzenia! ;)</font>");
			
			decl maxent,i3Zeus,i4Zeus;
			new String:weapon[64];
			maxent = GetMaxEntities();
			for (i3Zeus=0; i3Zeus<=maxent; i3Zeus++)
			{
				if (IsValidEdict(i3Zeus) && IsValidEntity(i3Zeus))
				{
					GetEdictClassname(i3Zeus, weapon, sizeof(weapon));
					if (StrContains(weapon, "weapon_") != -1 && StrContains(weapon, "weapon_knife") == -1) //
					{
						RemoveEdict(i3Zeus);
					}
				}
			}
			
			for (i4Zeus=1; i4Zeus<=MaxClients; i4Zeus++)
			{
				if(IsClientInGame(i4Zeus) && GetClientTeam(i4Zeus) != 0 && GetClientTeam(i4Zeus) != 1 && IsPlayerAlive(i4Zeus))
				{
					GivePlayerItem(i4Zeus, "weapon_taser");
				}
			}
			ServerCommand("mp_ignore_round_win_conditions 1");
			ServerCommand("mp_teammates_are_enemies 1");
			
			MyZeusOdliczanie = INVALID_HANDLE;
			handlezeus=INVALID_HANDLE;
			
			checkZeus = 1;
			
			GiveZeusEffects();
			
			MyGiveZeus2 = CreateTimer(4.1, GiveZeus2, _, TIMER_REPEAT);

			return Plugin_Stop;
		}
			
		else if (numPrinted3 <= 4)
		{
				
			if (numPrinted3 == 1)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>     Zeus War</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekunde!", numPrinted3); //KOLOR ZIELONY
				numPrinted3--;
					
				return Plugin_Continue;
			}				
			else if (numPrinted3 >= 2)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>     Zeus War</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekundy!", numPrinted3); //KOLOR JASNO ZIELONY
				numPrinted3--;
				
				return Plugin_Continue;				
			}
			
		}
			
		else if (numPrinted3 >= 5)
		{
			if (numPrinted3 == 24 || numPrinted3 == 23 || numPrinted3 == 22)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>     Zeus War</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekundy!", numPrinted3); //KOLOR ZlOTY
				numPrinted3--;
			}
				
			else
			{
				PrintHintTextToAll("<font size='40' color='#009900'>     Zeus War</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund!", numPrinted3); //KOLOR ZlOTY
				numPrinted3--;
			}
				
			return Plugin_Continue;
		}
	}
	return Plugin_Continue;
}

public Action:GiveZeus2(Handle:timer)
{
	if(koniecZeus == 1)
	{
		if(MyGiveZeus2 != INVALID_HANDLE)
		{
		KillTimer(MyGiveZeus2);
		MyGiveZeus2 = INVALID_HANDLE;
		}
		return Plugin_Stop;
	}
	
	else if(startZeus == 1 && koniecZeus == 0)
	{
		
		new k;
					
		for(k = 1; k <= MaxClients; k++)
		{
			if(IsClientInGame(k) && IsPlayerAlive(k))
			{
				FakeClientCommand(k, "use %s", "weapon_taser");
				//new clip;
				new entity_index = GetEntDataEnt2(k, g_hActiveWeapon);
				if (IsValidEdict(entity_index))
				{
					decl String:ActiveWeaponName[50];
					GetEdictClassname(entity_index, ActiveWeaponName, sizeof(ActiveWeaponName));
					if(strcmp(ActiveWeaponName, "weapon_taser") == 0)
					{
						//SetEntProp(entity_index, Prop_Send, "m_iClip1", 1, 4);
						//SetEntProp(entity_index, Prop_Data, "m_iClip1", 1, 4);
						//SetEntData(entity_index, "m_iClip1", 1, 4, true);
						//SetEntProp(entity_index, Prop_Send, "m_iAmmo", 1, 4);
						//SetEntProp(entity_index, Prop_Data, "m_iAmmo", 1, 4);
						//SetEntData(entity_index, "m_iAmmo", 1, 4, true);
						
						new ammo;
						ammo = GetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"));
						if(ammo == 1)
						{
							SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 2, 4, true);
						}
						if(ammo == 2)
						{
							SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 3, 4, true);
						}
						
						//SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 3, 4, true);
						//SetEntData(entity_index, FindSendPropInfo("CCSPlayer", "m_iAmmo"), 1, 4, true);
						
					
				//		SetEntData(k, g_iClip1, 2, 4, true);
				//	
				//		//SetEntData(k, g_iClip1, 2);
				//		//if (entity_index == GetPlayerWeaponSlot(k, 2))
				//		//	clip = g_PlayerMeleeAmmo[client_index];

				//		//if (clip)
				//		//	SetEntData(entity_index, g_iClip1, clip, 4, true);
					}
				//	
					else
					{
						GivePlayerItem(k, "weapon_taser");
					}
				}
				
				else
				{
				GivePlayerItem(k, "weapon_taser");
				}

				//GivePlayerItem(k, "weapon_taser");
				FakeClientCommand(k, "use %s", "weapon_taser");
				RemoveGroundWeapon();
			}
			
		}
	}
	
	return Plugin_Continue;
}

public RemoveGroundWeapon()
{
	if(koniecZeus == 1)
	{

	}
	
	else if(startZeus == 1)
	{
		new maxent = GetMaxEntities(), String:weapon[64];
		for (new i=GetMaxClients();i<maxent;i++)
		{
			if ( IsValidEdict(i) && IsValidEntity(i) )
			{
				GetEdictClassname(i, weapon, sizeof(weapon));
				if ( ( StrContains(weapon, "weapon_") != -1 || StrContains(weapon, "item_") != -1 ) && GetEntDataEnt2(i, g_WeaponParent) == -1 )
				{
					AcceptEntityInput(i, "Kill");
				}
			}
		}
	}
}

public Action:KillZeus(Event event, const char[] name, bool dontBroadcast)
{

	if(koniecZeus == 1)
	{
		return Plugin_Stop;
	}
	
	else if(startZeus == 1)
	{
		int attackerId = event.GetInt("attacker");
		int zeusAttacker = GetClientOfUserId(attackerId);
		
		FakeClientCommand(zeusAttacker, "use %s", "weapon_taser");
		//new clip;
		new entity_index = GetEntDataEnt2(zeusAttacker, g_hActiveWeapon);
		if (IsValidEdict(entity_index))
		{
			decl String:ActiveWeaponName[50];
			GetEdictClassname(entity_index, ActiveWeaponName, sizeof(ActiveWeaponName));
			if(strcmp(ActiveWeaponName, "weapon_taser") == 0)
			{
				//SetEntProp(entity_index, Prop_Send, "m_iClip1", 1, 4);
				//SetEntProp(entity_index, Prop_Data, "m_iClip1", 1, 4);
				//SetEntData(entity_index, "m_iClip1", 1, 4, true);
				//SetEntProp(entity_index, Prop_Send, "m_iAmmo", 1, 4);
				//SetEntProp(entity_index, Prop_Data, "m_iAmmo", 1, 4);
				//SetEntData(entity_index, "m_iAmmo", 1, 4, true);
				
				new ammo;
				ammo = GetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"));
				if(ammo == 1)
				{
					SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 2, 4, true);
				}
				if(ammo == 2)
				{
					SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 3, 4, true);
				}
						
				//SetEntData(entity_index, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 3, 4, true);
				//SetEntData(entity_index, FindSendPropInfo("CCSPlayer", "m_iAmmo"), 1, 4, true);
						
					
				//		SetEntData(zeusAttacker, g_iClip1, 2, 4, true);
				//	
				//		//SetEntData(zeusAttacker, g_iClip1, 2);
				//		//if (entity_index == GetPlayerWeaponSlot(zeusAttacker, 2))
				//		//	clip = g_PlayerMeleeAmmo[client_index];

				//		//if (clip)
				//		//	SetEntData(entity_index, g_iClip1, clip, 4, true);
			}
				//	
			else
			{
				GivePlayerItem(zeusAttacker, "weapon_taser");
			}
		}
				
		else
		{
			GivePlayerItem(zeusAttacker, "weapon_taser");
		}
		
		new j; new iCount2; iCount2 = 0; new j3;
				
		for(j = 1; j <= MaxClients; j++)
		{
			if(IsClientInGame(j) && IsPlayerAlive(j))
			{
				iCount2++;
			}
		}
		if(iCount2 == 1)
		{
			koniecZeus = 1;
			for(j3 = 1; j3 <= MaxClients; j3++)
			{
				if(IsClientInGame(j3) && IsPlayerAlive(j3))
				{
					SetEntPropFloat(j3, Prop_Data, "m_flLaggedMovementValue", 1.0);
				}
			}
			
			for(new j4=1;j4<GetMaxClients();j4++)
			{
				SDKUnhook(j4, SDKHook_OnTakeDamage,OnTakeDamage);
				SDKUnhook(j4, SDKHook_WeaponCanUse,OnWeaponCanUse);
				SDKUnhook(j4, SDKHook_TraceAttack,TraceAttack);
				if(IsClientInGame(j4) && IsPlayerAlive(j4))
				{
					if(GetClientTeam(j4)==CS_TEAM_T)
						SetEntityRenderColor(j4, 255, 255, 255, 255);
					SetEntPropFloat(j4, Prop_Data, "m_flLaggedMovementValue",1.0);
					if(GetEntityFlags(j4) & FL_ATCONTROLS)
					{
						SetEntityFlags(j4, GetEntityFlags(j4)^FL_ATCONTROLS);
					}
				}
			}
			UsunZabawe();
			//ServerCommand("mp_teammates_are_enemies 0");
			//ServerCommand("mp_ignore_round_win_conditions 0");
			//PrintHintTextToAll("Runda sie skonczyla, wszyscy zostaja zgladzeni.");
			//for (new i=1; i<=GetMaxClients(); i++)
			//{
			//	if (IsClientInGame(i) && !IsClientObserver(i) && IsPlayerAlive(i))
			//	{
			//		new deaths = GetEntProp(i, Prop_Data, "m_iDeaths");
			//		SetEntProp(i, Prop_Data, "m_iDeaths", deaths-1);
			//		new kills = GetEntProp(i, Prop_Data, "m_iFrags");
			//		SetEntProp(i, Prop_Data, "m_iFrags", kills+1);
			//		ForcePlayerSuicide(i);
			//	}
			//}
			//CS_TerminateRound(6.0, CSRoundEnd_CTWin, true); 
			if(handlezab1!=INVALID_HANDLE)
			{
				KillTimer(handlezab1);
				handlezab1=INVALID_HANDLE;
			}
			if(handlezab2!=INVALID_HANDLE)
			{
				KillTimer(handlezab2);
				handlezab2=INVALID_HANDLE;
			}
			if(handlezab3!=INVALID_HANDLE)
			{
				KillTimer(handlezab3);
				handlezab3=INVALID_HANDLE;
			}
			odliczanie=3.0;
			handlezab2=CreateTimer(0.1,KoniecInfo,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
			handlezab3=CreateTimer(3.2,Koniec,_,TIMER_FLAG_NO_MAPCHANGE);
			
		}
		
		else if(iCount2 < 1)
		{
			koniecZeus = 1;
			
			for(new j4=1;j4<GetMaxClients();j4++)
			{
				SDKUnhook(j4, SDKHook_OnTakeDamage,OnTakeDamage);
				SDKUnhook(j4, SDKHook_WeaponCanUse,OnWeaponCanUse);
				SDKUnhook(j4, SDKHook_TraceAttack,TraceAttack);
				if(IsClientInGame(j4) && IsPlayerAlive(j4))
				{
					if(GetClientTeam(j4)==CS_TEAM_T)
						SetEntityRenderColor(j4, 255, 255, 255, 255);
					SetEntPropFloat(j4, Prop_Data, "m_flLaggedMovementValue",1.0);
					if(GetEntityFlags(j4) & FL_ATCONTROLS)
					{
						SetEntityFlags(j4, GetEntityFlags(j4)^FL_ATCONTROLS);
					}
				}
			}
			
			//ServerCommand("mp_teammates_are_enemies 0");
			//ServerCommand("mp_ignore_round_win_conditions 0");
			//PrintHintTextToAll("Runda sie skonczyla, wszyscy zostaja zgladzeni.");
			//for (new i=1; i<=GetMaxClients(); i++)
			//{
			//	if (IsClientInGame(i) && !IsClientObserver(i) && IsPlayerAlive(i))
			//	{
			//		new deaths = GetEntProp(i, Prop_Data, "m_iDeaths");
			//		SetEntProp(i, Prop_Data, "m_iDeaths", deaths-1);
			//		new kills = GetEntProp(i, Prop_Data, "m_iFrags");
			//		SetEntProp(i, Prop_Data, "m_iFrags", kills+1);
			//		ForcePlayerSuicide(i);
			//	}
			//}
			//CS_TerminateRound(6.0, CSRoundEnd_CTWin, true); 
			UsunZabawe();
			if(handlezab1!=INVALID_HANDLE)
			{
				KillTimer(handlezab1);
				handlezab1=INVALID_HANDLE;
			}
			if(handlezab2!=INVALID_HANDLE)
			{
				KillTimer(handlezab2);
				handlezab2=INVALID_HANDLE;
			}
			if(handlezab3!=INVALID_HANDLE)
			{
				KillTimer(handlezab3);
				handlezab3=INVALID_HANDLE;
			}
			odliczanie=3.0;
			handlezab2=CreateTimer(0.1,KoniecInfo,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
			handlezab3=CreateTimer(3.2,Koniec,_,TIMER_FLAG_NO_MAPCHANGE);
			
		}
	}
	
	return Plugin_Continue;
}

public GiveZeusEffects()
{
	for (new iGiveZE=1; iGiveZE<=MaxClients; iGiveZE++)
	{
		new randomhealth;
		if(IsClientInGame(iGiveZE) && IsPlayerAlive(iGiveZE))
		{
			speed(iGiveZE, 0.925);
			new healthZeus;
			healthZeus = 350 + randomhealth;
			health(iGiveZE, healthZeus);
		}
	}
	ServerCommand("sv_gravity 250");
}

public speed(client, Float:speed)
{
	if(IsClientInGame(client) && IsPlayerAlive(client))
	{
		SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", speed); 
	}
}

public gravity(client, Float:amount)
{
	if(IsClientInGame(client) && IsPlayerAlive(client))
	{
		SetEntityGravity(client, amount);
	}
}

public froggyjump(client)
{
	new Float:velocity[3];
	new Float:velocity0;
	new Float:velocity1;
	new Float:velocity2;
	new Float:velocity2_new;

	velocity0 = GetEntPropFloat(client, Prop_Send, "m_vecVelocity[0]");
	velocity1 = GetEntPropFloat(client, Prop_Send, "m_vecVelocity[1]");
	velocity2 = GetEntPropFloat(client, Prop_Send, "m_vecVelocity[2]");

	velocity2_new = 260.0;

	if (velocity2 < 150.0) 
		velocity2_new = 270.0;
	if (velocity2 < 100.0) 
		velocity2_new = 300.0;
	if (velocity2 < 50.0) 
		velocity2_new = 330.0;
	if (velocity2 < 0.0) 
		velocity2_new = 380.0;
	if (velocity2 < -50.0) 
		velocity2_new = 400.0;
	if (velocity2 < -100.0) 
		velocity2_new = 430.0;
	if (velocity2 < -150.0) 
		velocity2_new = 450.0;
	if (velocity2 < -200.0) 
		velocity2_new = 470.0;

	velocity[0] = velocity0 * 0.1;
	velocity[1] = velocity1 * 0.1;
	velocity[2] = velocity2_new;
	
	SetEntPropVector(client, Prop_Send, "m_vecBaseVelocity", velocity);
}

public health(client, amount)
{
	SetEntityHealth(client, GetClientHealth(client) + amount);
}