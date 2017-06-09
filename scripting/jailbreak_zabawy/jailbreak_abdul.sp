#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define VER "2.5.3.15"
#define SOUND_BOOM "ambient/explosions/explode_8.wav"

//new Float:vecTarget[3] = NULL_VECTOR;
//new Float:vecVelocity[3] = {0.0, 0.0, 500.0};

new startAbdul = 0;
new koniecAbdul = 0;

new numPrinted = 30;
new numPrinted2 = -1;
new bomba = 0;

new Abdul;

new g_fire;
new g_HaloSprite;
new g_ExplosionSprite;

new Handle:MyAbdulOdliczanie; 
new Handle:MyAbdulWybuch;
new Handle:MyAbdulDrop;

new Handle:handleabdul=INVALID_HANDLE;

public Action:OnWeaponEquip(client, weapon) 
{
	if(koniecAbdul == 1)
	{
	
	}
	
	else if(startAbdul == 1)
	{
		if(GetClientTeam(client) == 2)
		{
			decl String:sWeapon[32]; 
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon)); 
				
			if(StrEqual(sWeapon, "weapon_c4")) 
			{
				if(MyAbdulDrop != INVALID_HANDLE)
				{
					KillTimer(MyAbdulDrop);
					MyAbdulDrop = INVALID_HANDLE;
				}
				if(client != Abdul)
				{
					SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 0.70);
					for (new x=1; x <= 5; x++) 
							CreateTimer(0.2*x, teleport, Abdul);
					Abdul = client;
					char newname[32]; 
					GetClientName(Abdul, newname, sizeof(newname)); //pobiera nazwe clienta
					SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 1.25);
				}
				
				else
				{
					SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 1.25);
				}
			}
			
			else if(StrEqual(sWeapon, "weapon_knife"))
			{
				return Plugin_Continue;
			}
			
			else
			{
				return Plugin_Stop;
			}
		
		}
		
	}
	
	return Plugin_Continue; 
}  

public Action:teleport(Handle:timer, any:client)
{
	if (!IsClientInGame(client) || !IsPlayerAlive(client))
		return Plugin_Stop;
		
	new Float:velocity[3];
	new Float:angles[3];
	new Float:velocity0;
	new Float:velocity1;

	//velocity[0] = 500.0;
	//velocity[1] = 350.0;
	velocity[2] = 265.0;
	GetEntPropVector(client, Prop_Data, "m_angRotation", angles);
	
	
	//angles[0] = angles[0] * 3;
	//angles[1] = angles[1] * 3;
	//angles[0] = (7.0 * angles[0]) * (1.0 / 4.1) * 250;
	//angles[1] = (7.0 * angles[1]) * (1.0 / 4.1) * 250;
	
	velocity0 = GetEntPropFloat(client, Prop_Send, "m_vecVelocity[0]");
	velocity1 = GetEntPropFloat(client, Prop_Send, "m_vecVelocity[1]");
	
	velocity[0] = (4.4 * velocity0) * (1.0 / 4.1);
	velocity[1] = (4.4 * velocity1) * (1.0 / 4.1);
	
	velocity[0] = velocity[0] + angles[0];
	velocity[1] = velocity[1] + angles[1];
	
	TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, velocity);
	
	//float fEyeAngles[3], fDirection[3];
        //GetClientEyeAngles(client, fEyeAngles);
        //GetAngleVectors(fEyeAngles, fDirection, NULL_VECTOR, NULL_VECTOR);
        //ScaleVector(fDirection, 2000.0);
        //TeleportEntity(client, fDirection, NULL_VECTOR, NULL_VECTOR);  
	
	return Plugin_Handled;
}

public Action:AbdulStart(client)
{

		PrintToChatAll("\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 1. Zabawa polega na unikaniu terrorysty z bomba.");
		PrintToChatAll("\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 2. Po rozpoczeciu zabawy, terrorysci maja 30 sekund na rozbiegniecie sie po mapie.");
		PrintToChatAll("\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 3. Co 15 sekund bomba wybucha, raniac przy tym osoby w poblizu.");
		PrintToChatAll("\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 4. Jezeli trzymasz bombe, musisz ja komus jak najszybciej podrzucic.");
		PrintToChatAll("\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 5. Ostatni wiezien ma zyczenie.");
					
				
		numPrinted = 30;
		numPrinted2 = -1;
		startAbdul = 1;
		koniecAbdul = 0;
		Abdul = 0;
				
		MyAbdulOdliczanie = CreateTimer(1.0, AbdulOdliczanie, _, TIMER_REPEAT); //Odliczanie do startu zabawy

		for(new i2=1; i2 <= GetMaxClients(); i2++)
		{
			if(IsClientInGame(i2) && IsPlayerAlive(i2))
			{
				SDKHook(i2, SDKHook_OnTakeDamage, OnTakeDamage);
				SDKHook(i2, SDKHook_TraceAttack, TraceAttack);
				SetEntProp(i2,Prop_Send,"m_iHideHUD",GetEntProp(i2,Prop_Send,"m_iHideHUD")^1<<12);
				if(GetClientTeam(i2)!=CS_TEAM_CT)
				{
					Client_RemoveAllWeapons(i2,"weapon_knife",true);
				}
			}
		}
		
		handleabdul=CreateTimer(30.0,AbdulAnuluj);
}

public Action:AbdulAnuluj(Handle:timer)
{
	handleabdul=INVALID_HANDLE;
}

public Action:AbdulOdliczanie(Handle:timer)
{
	if(koniecAbdul == 1)
	{
		if(MyAbdulOdliczanie != INVALID_HANDLE)
		{
		KillTimer(MyAbdulOdliczanie);
		MyAbdulOdliczanie = INVALID_HANDLE;
		}
		return Plugin_Stop;
	}
	
	else if(startAbdul == 1 && koniecAbdul == 0)
	{
		if (numPrinted <= 0)
		{
			PrintHintTextToAll("Zabawa sie zaczela!\n<font color='#009900'>Powodzenia! ;)</font>");
			
			decl i2;
			
			ServerCommand("mp_ignore_round_win_conditions 1");
			
			for (i2=1; i2<=MaxClients; i2++)
			{
				if(IsClientInGame(i2) && GetClientTeam(i2) == 2 && IsPlayerAlive(i2))
				{
					SetEntPropFloat(i2, Prop_Data, "m_flLaggedMovementValue", 0.70);
					if(GetClientTeam(i2)!=CS_TEAM_CT)
					{
						Client_RemoveAllWeapons(i2,"weapon_knife",true);
					}
				}
			}
			
			MyAbdulWybuch = CreateTimer(1.0, AbdulWybuch, _, TIMER_REPEAT);

			MyAbdulOdliczanie = INVALID_HANDLE;
			handleabdul=INVALID_HANDLE;

			return Plugin_Stop;
		}
			
		else if (numPrinted <= 4)
		{
				
			if (numPrinted == 1)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>        Abdul</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekunde!", numPrinted); //KOLOR ZIELONY
				numPrinted--;
					
				return Plugin_Continue;
			}				
			else if (numPrinted >= 2)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>        Abdul</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekundy!", numPrinted); //KOLOR JASNO ZIELONY
				numPrinted--;
				
				return Plugin_Continue;				
			}
			
		}
			
		else if (numPrinted >= 5)
		{
			if (numPrinted == 24 || numPrinted == 23 || numPrinted == 22)
			{
				PrintHintTextToAll("<font size='40' color='#009900'>        Abdul</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekundy!", numPrinted); //KOLOR ZlOTY
				numPrinted--;
			}
				
			else
			{
				PrintHintTextToAll("<font size='40' color='#009900'>        Abdul</font>\n    Start zabawy za <font color='#FF0000'>%d</font> sekund!", numPrinted); //KOLOR ZlOTY
				numPrinted--;
			}
				
			return Plugin_Continue;
		}
	}
	return Plugin_Continue;
}


public Action:AbdulWybuch(Handle:timer)
{

	if(koniecAbdul == 1)
	{
		MyAbdulWybuch = INVALID_HANDLE;
		return Plugin_Stop;
	}
		
	else if(startAbdul == 1 && numPrinted <= 0 && koniecAbdul == 0)
	{
		if(Abdul > 0)
		{
			if(!IsClientInGame(Abdul) || GetClientTeam(Abdul) != 2 || !IsPlayerAlive(Abdul))
			{
				PrintHintTextToAll("<font color='#cca300' size='24' face='roboto'>\n &nbsp;Nowy Abdul zostal wybrany!</font>"); //KOLOR ZlOTY
			
				NowyAbdul();
						
				//new6
						
				return Plugin_Handled;
			}
		}
		
		if(Abdul == 0)
		{
			PrintHintTextToAll("<font color='#cca300' size='24' face='roboto'>\n &nbsp;Nowy Abdul zostal wybrany!</font>"); //KOLOR ZlOTY
			
			NowyAbdul();
						
			//new6
						
			return Plugin_Handled;
		}
				
		if(numPrinted2 == -1)
		{
			
			NowyAbdul();
			
			return Plugin_Handled;
				
		}
			
		else if(numPrinted2 == 0) //Jezeli odliczanie sie skonczy, Abdul wybucha
		{

			if(IsClientInGame(Abdul) && GetClientTeam(Abdul) == 2 && IsPlayerAlive(Abdul))
			{

				char nameWybuch[32]; 
				GetClientName(Abdul, nameWybuch, sizeof(nameWybuch));
					
				decl String:target_name[MAX_TARGET_LENGTH];
				decl target_list[MAXPLAYERS], target_count, bool:tn_is_ml;
					
				if ((target_count = ProcessTargetString(
					nameWybuch,
					0,
					target_list,
					MAXPLAYERS,
					COMMAND_FILTER_ALIVE,
					target_name,
					sizeof(target_name),
					tn_is_ml)) <= 0) {
					ReplyToTargetError(Abdul, target_count);
					return Plugin_Handled;
				}
					
				for (new i = 0; i < target_count; i++) {
					PerformExplode(Abdul, target_list[i]);
				}
				
			}
						
			PrintHintTextToAll("<font color='#cca300' size='24' face='roboto'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Abdul wybuchl! \n &nbsp;Nowy Abdul zostal wybrany!</font>"); //KOLOR ZlOTY
				
			NowyAbdul();
					
			//new6
					
			return Plugin_Handled;
				
		}
			
		else if (numPrinted2 >= 5)
		{

			PrintHintTextToAll("<font color='#cca300' size='24' face='roboto'>&nbsp;&nbsp;&nbsp;Abdul wybuchnie za: \n <font color='#cca300' size='36' face='roboto'>&nbsp;&nbsp;&nbsp;%d sekund!", numPrinted2); //KOLOR ZlOTY SHIFT+CTRL+LITERA= SOH STX BS ITP. LOL
			PrintToChat(Abdul, "Wybuchniesz za %d sekund!", numPrinted2);
			numPrinted2--;
					
			return Plugin_Continue;
		}
				
		else if (numPrinted2 <= 4)
		{

			if (numPrinted2 == 1)
			{
				PrintHintTextToAll("<font color='#e60000' size='24' face='roboto'>&nbsp;&nbsp;&nbsp;Abdul wybuchnie za:</font> \n<font color='#e60000' size='36' face='roboto'>&nbsp;&nbsp;&nbsp;%d sekunde!</font>", numPrinted2); //KOLOR CZERWONY
				PrintToChat(Abdul, "Wybuchniesz za %d sekunde!", numPrinted2);
				numPrinted2--;
						
				return Plugin_Continue;
			}
					
			else if (numPrinted2 >= 2)
			{
				PrintHintTextToAll("<font color='#ff4d4d' size='24' face='roboto'>&nbsp;&nbsp;&nbsp;Abdul wybuchnie za:</font> \n<font color='#ff4d4d' size='36' face='roboto'>&nbsp;&nbsp;&nbsp;%d sekundy!</font>", numPrinted2); //KOLOR JASNO CZERWONY
				PrintToChat(Abdul, "Wybuchniesz za %d sekundy!", numPrinted2);
				numPrinted2--;
						
				return Plugin_Continue;
			}
					
		}
	}

	return Plugin_Continue;
	
}

public Action:KillAbdul(Handle:event, const String:name[], bool:dontBroadcast)
{

	if(koniecAbdul == 1)
	{
	
	}
	
	else if(startAbdul == 1 && numPrinted <= 0)
	{
		
		NowyAbdul();
		//new6
		
	}
	
	return Plugin_Continue;
}


public Action:RoundEndAbdul(Handle:event, const String:name[], bool:dontBroadcast)
{

	if(koniecAbdul == 0 && startAbdul == 1) //sprawdza czy zabawa trwa
	{
		koniecAbdul = 1;
		if(MyAbdulWybuch!=INVALID_HANDLE)
		{
			KillTimer(MyAbdulWybuch);
			MyAbdulWybuch=INVALID_HANDLE;
		}
		if(MyAbdulOdliczanie!=INVALID_HANDLE)
		{
			KillTimer(MyAbdulOdliczanie);
			MyAbdulOdliczanie=INVALID_HANDLE;
		}
	}
	
	if(koniecZeus == 0 && startZeus == 1)
	{
		koniecZeus = 1;
		UsunZabawe();
	}
}


public Action:DisconnectAbdul(Handle:event, const String:name[], bool:dontBroadcast)
{

	if(koniecAbdul == 1)
	{
		return Plugin_Stop;
	}
	
	else if(startAbdul == 1 && numPrinted <= 0)
	{
		
		NowyAbdul();
		//new6
		
	}
	
	return Plugin_Continue;
}

//stock VelocityByAim(client, Float:fVelocity[3], Float:power)
//{
//	GetEntPropVector(client, Prop_Data, "m_vecVelocity", fVelocity);
//	decl Float:ang[3];
//	GetClientEyeAngles(client, ang);
//		
//	GetAngleVectors(ang, fVelocity, NULL_VECTOR, NULL_VECTOR);
//	NormalizeVector(fVelocity, fVelocity);
//	ScaleVector(fVelocity, power);
//}

public Action:OnWeaponDrop(client, weapon) 
{
	if(koniecAbdul == 1)
	{
		return Plugin_Continue;
	}
	
	else if(startAbdul == 1 && numPrinted <= 0)
	{
	
		if(client == Abdul)
		{
			decl String:sWeapon2[32];
			if(weapon != -1)
			{
				GetEdictClassname(weapon, sWeapon2, sizeof(sWeapon2)); 
				
				if(StrEqual(sWeapon2, "weapon_c4")) 
				{ 
					SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 0.70);
				} 
			}
			
			MyAbdulDrop = CreateTimer(4.0, AbdulDrop); //Odliczanie do startu zabawy
			return Plugin_Continue;
		}

	}
	return Plugin_Continue;
	
	//decl Float:fVelocity[3];
	//VelocityByAim(client, fVelocity, 0.01);
	//SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 4), NULL_VECTOR, fVelocity);
	//
	//if(koniecAbdul == 0 && startAbdul == 1) //sprawdza czy zabawa trwa
	//{
	//
	//	if(client == Abdul)
	//	{
	//		SDKHooks_DropWeapon(client, GetPlayerWeaponSlot(client, 4), NULL_VECTOR, vecVelocity);
	//	}
	//	
	//	else
	//	{
	//		PrintToChat(client, "nie abdul");
	//	}
	//
	//}
	
}

public Action:AbdulDrop(Handle:timer)
{
	if(koniecAbdul == 1)
	{
		if(MyAbdulDrop!=INVALID_HANDLE)
		{
			KillTimer(MyAbdulDrop);
			MyAbdulDrop = INVALID_HANDLE;
		}
	}
	
	else if(startAbdul == 1 && numPrinted <= 0)
	{
		if(IsClientInGame(Abdul) && IsPlayerAlive(Abdul) && GetClientTeam(Abdul) == 2)
		{
			bomba = GetPlayerWeaponSlot(Abdul, 4);
			if(bomba != 49)
			{
				decl maxent,i;
				new String:weapon[64];
				maxent = GetMaxEntities();
				for (i=0; i<=maxent; i++)
				{

					if (IsValidEdict(i) && IsValidEntity(i))
					{
						GetEdictClassname(i, weapon, sizeof(weapon));
						if (StrContains(weapon, "weapon_c4") != -1)
						{
							RemoveEdict(i);
						}
					}
				}	

				GivePlayerItem(Abdul, "weapon_c4");
				//SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 1.25);
				MyAbdulDrop = INVALID_HANDLE;
			}
		}
		
	}
	return Plugin_Continue;
}

public NowyAbdul() 
{
	if(koniecAbdul == 1)
	{
	
	}
	
	else if(startAbdul == 1 && numPrinted <= 0)
	{
		if(Abdul == 0)
		{
			decl maxent,i;
			new String:weapon[64];
			maxent = GetMaxEntities();
			for (i=0; i<=maxent; i++)
			{
				if (IsValidEdict(i) && IsValidEntity(i))
				{
					GetEdictClassname(i, weapon, sizeof(weapon));
					if (StrContains(weapon, "weapon_c4") != -1)
					{
						RemoveEdict(i);
					}
				}
			}
		
			numPrinted2 = 15;
			PrintHintTextToAll("<font color='#cca300' size='22' face='roboto'>\n&nbsp;Nowy Abdul zostal wybrany!</font>"); //KOLOR ZlOTY
			if(GetTeamClientCount(2) > 0)
			{
				
				do
				{
					Abdul = GetRandomInt(1, MaxClients);
				}
				while(!IsClientInGame(Abdul) || GetClientTeam(Abdul) != 2);
											
				if (IsPlayerAlive(Abdul))
				{
					char name3[32]; 
					GetClientName(Abdul, name3, sizeof(name3)); //pobiera nazwe clienta
									
					numPrinted2 = 15;
									
					GivePlayerItem(Abdul, "weapon_c4");
					SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 1.25);
				}
			}
		}
		
		else
		{

			if(!IsClientInGame(Abdul) || GetClientTeam(Abdul) != 2 || !IsPlayerAlive(Abdul))
			{

				PrintHintTextToAll("<font color='#cca300' size='24' face='roboto'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Abdul wybuchl! \n &nbsp;Nowy Abdul zostal wybrany!</font>"); //KOLOR ZlOTY
							
				decl maxent,i;
				new String:weapon[64];
				maxent = GetMaxEntities();
				for (i=0; i<=maxent; i++)
				{
					if (IsValidEdict(i) && IsValidEntity(i))
					{
						GetEdictClassname(i, weapon, sizeof(weapon));
						if (StrContains(weapon, "weapon_c4") != -1)
						{
							RemoveEdict(i);
						}
					}
				}
				
				if(GetTeamClientCount(2) > 0)
				{
				
					do
					{
						Abdul = GetRandomInt(1, MaxClients);
					}
					while(!IsClientInGame(Abdul) || GetClientTeam(Abdul) != 2);
											
					if (IsPlayerAlive(Abdul))
					{
						char name3[32]; 
						GetClientName(Abdul, name3, sizeof(name3)); //pobiera nazwe clienta
									
						numPrinted2 = 15;
									
						GivePlayerItem(Abdul, "weapon_c4");
						SetEntPropFloat(Abdul, Prop_Data, "m_flLaggedMovementValue", 1.25);
					}
									
				}
			}
		
		}
				
		new i; new iCount; iCount = 0; new i3;
				
		char name2[32]; 
		name2 = "none";
					
		for(i = 1; i <= MaxClients; i++)
		{
			if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				GetClientName(i, name2, sizeof(name2));
				iCount++;
			}
		}
					
		if(iCount == 1)
		{
			ServerCommand("mp_ignore_round_win_conditions 0");
			PrintHintTextToAll("<font color='#009933' size='24' face='roboto'>&nbsp;Zabawe wygral: %s \n &nbsp;&nbsp;Przysluguje mu zyczenie!</font>", name2); //KOLOR ZIELONY
			koniecAbdul = 1;
			for(i3 = 1; i3 <= MaxClients; i3++)
			{
				if(IsClientInGame(i3) && IsPlayerAlive(i3) && GetClientTeam(i3) == 2)
				{
					SetEntPropFloat(i3, Prop_Data, "m_flLaggedMovementValue", 1.0);
				}
			}
			for(new i4=1;i4<GetMaxClients();i4++)
			{
				SDKUnhook(i4, SDKHook_OnTakeDamage,OnTakeDamage);
				SDKUnhook(i4, SDKHook_WeaponCanUse,OnWeaponCanUse);
				SDKUnhook(i4, SDKHook_TraceAttack,TraceAttack);
				if(IsClientInGame(i4) && IsPlayerAlive(i4))
				{
					if(GetClientTeam(i4)==CS_TEAM_T)
						SetEntityRenderColor(i4, 255, 255, 255, 255);
					if(GetEntityFlags(i4) & FL_ATCONTROLS)
					{
						SetEntityFlags(i4, GetEntityFlags(i4)^FL_ATCONTROLS);
					}
				}
			}
			UsunZabawe();
		}
			
		else if(iCount < 1)
		{
			koniecAbdul = 1;
			for(new i4=1;i4<GetMaxClients();i4++)
			{
				SDKUnhook(i4, SDKHook_OnTakeDamage,OnTakeDamage);
				SDKUnhook(i4, SDKHook_WeaponCanUse,OnWeaponCanUse);
				SDKUnhook(i4, SDKHook_TraceAttack,TraceAttack);
				if(IsClientInGame(i4) && IsPlayerAlive(i4))
				{
					if(GetClientTeam(i4)==CS_TEAM_T)
						SetEntityRenderColor(i4, 255, 255, 255, 255);
					SetEntPropFloat(i4, Prop_Data, "m_flLaggedMovementValue",1.0);
					if(GetEntityFlags(i4) & FL_ATCONTROLS)
					{
						SetEntityFlags(i4, GetEntityFlags(i4)^FL_ATCONTROLS);
					}
				}
			}

			ServerCommand("mp_ignore_round_win_conditions 0");
			PrintHintTextToAll("<font color='#009933' size='24' face='roboto'>Nikt nie wygral zabawy!</font>", name2); //KOLOR ZIELONY
			//UsunZabawe();
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
	
}

public PerformExplode(client, target) 
{
	new radius = 600;
	
	decl Float:location[3];
	GetClientAbsOrigin(target, location);

	new color[4]={188,220,255,200};
	EmitAmbientSound(SOUND_BOOM, location, client, SNDLEVEL_RAIDSIREN);
	TE_SetupExplosion(location, g_ExplosionSprite, 10.0, 1, 0, radius, 5000);
	TE_SendToAll();
	TE_SetupBeamRingPoint(location, 10.0, float(radius), g_fire, g_HaloSprite, 0, 10, 0.6, 10.0, 0.5, color, 10, 0);
  	TE_SendToAll();

	ForcePlayerSuicide(target);
	HurtOtherPlayers(target, radius, true);
}
public HurtOtherPlayers(target, radius, bool:teamonly) 
{
	new maxClients = GetMaxClients();
	new Float:vec[3];
	GetClientAbsOrigin(target, vec);
	for (new i = 1; i < maxClients; ++i) {
		if (!IsClientInGame(i) || !IsPlayerAlive(i) || target == i
				|| (teamonly && GetClientTeam(i) != GetClientTeam(target)))
			continue;
		
		new Float:pos[3];
		GetClientEyePosition(i, pos);
		new Float:distance = GetVectorDistance(vec, pos);
		if (distance > radius)
			continue;

		new damage = 175;
		damage = RoundToFloor(damage * (radius - distance) / radius);
		SlapPlayer(i, damage, false);
		TE_SetupExplosion(pos, g_ExplosionSprite, 0.05, 1, 0, 1, 1);
		TE_SendToAll();
	}
	
	new i; new iCount; iCount = 0; new i3;
			
	char name2[32]; 
	name2 = "none";
			
	for(i = 1; i <= MaxClients; i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
		{
			GetClientName(i, name2, sizeof(name2));
			iCount++;
		}
	}
			
	if(iCount == 1)
	{
		ServerCommand("mp_ignore_round_win_conditions 0");
		PrintHintTextToAll("<font color='#009933' size='24' face='roboto'>&nbsp;Zabawe wygral: %s \n &nbsp;&nbsp;Przysluguje mu zyczenie!</font>", name2); //KOLOR ZIELONY
		koniecAbdul = 1;
		for(i3 = 1; i3 <= MaxClients; i3++)
		{
			if(IsClientInGame(i3) && IsPlayerAlive(i3) && GetClientTeam(i3) == 2)
			{
			SetEntPropFloat(i3, Prop_Data, "m_flLaggedMovementValue", 1.0);
			}
		}
		for(new i4=1;i4<GetMaxClients();i4++)
		{
			SDKUnhook(i4, SDKHook_OnTakeDamage,OnTakeDamage);
			SDKUnhook(i4, SDKHook_WeaponCanUse,OnWeaponCanUse);
			SDKUnhook(i4, SDKHook_TraceAttack,TraceAttack);
			if(IsClientInGame(i4) && IsPlayerAlive(i4))
			{
				if(GetClientTeam(i4)==CS_TEAM_T)
					SetEntityRenderColor(i4, 255, 255, 255, 255);
				SetEntPropFloat(i4, Prop_Data, "m_flLaggedMovementValue",1.0);
				if(GetEntityFlags(i4) & FL_ATCONTROLS)
				{
					SetEntityFlags(i4, GetEntityFlags(i4)^FL_ATCONTROLS);
				}
			}
		}
		UsunZabawe();
	}
	
	else if(iCount < 1)
	{
		koniecAbdul = 1;
		for(new i4=1;i4<GetMaxClients();i4++)
		{
			SDKUnhook(i4, SDKHook_OnTakeDamage,OnTakeDamage);
			SDKUnhook(i4, SDKHook_WeaponCanUse,OnWeaponCanUse);
			SDKUnhook(i4, SDKHook_TraceAttack,TraceAttack);
			if(IsClientInGame(i4) && IsPlayerAlive(i4))
			{
				if(GetClientTeam(i4)==CS_TEAM_T)
					SetEntityRenderColor(i4, 255, 255, 255, 255);
				SetEntPropFloat(i4, Prop_Data, "m_flLaggedMovementValue",1.0);
				if(GetEntityFlags(i4) & FL_ATCONTROLS)
				{
					SetEntityFlags(i4, GetEntityFlags(i4)^FL_ATCONTROLS);
				}
			}
		}
		
		
		ServerCommand("mp_ignore_round_win_conditions 0");
		PrintHintTextToAll("<font color='#009933' size='24' face='roboto'>Nikt nie wygral zabawy!</font>", name2); //KOLOR ZIELONY
		//UsunZabawe();
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