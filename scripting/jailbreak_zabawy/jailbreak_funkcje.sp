public Action:PokazReguly(client,args)
{
	if(numerZabawy==1)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 1. Wiezniowie rozbiegaja sie po mapie, Straznicy zostaja w GR.");
		PrintToChat(client,"\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 2. Po minucie Straznicy wybiegaja z GR. Straznicy zabijaja tylko z AWP, Wiezniowie tylko z noza.");
		PrintToChat(client,"\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 3. Zakaz kampienia w Medyku, w bezposrednim otoczeniu GR oraz przy Teleportach.");
		PrintToChat(client,"\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 4. Jesli Wiezien wejdzie do GR przed wyjsciem Straznikow, moze zostac zabity z dowolnej broni.");
		PrintToChat(client,"\x01[\x04Zabawy - Polowanie\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	} else
	if(numerZabawy==2)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 1. Gracze rozbiegaja sie po mapie, po minucie zostaje wlaczony box.");
		PrintToChat(client,"\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 2. CT walcza miedzy CT, TT walczy miedzy TT. Gdy przy zyciu zostanie po jednym graczu z druzyny, walcza miedzy soba.");
		PrintToChat(client,"\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 3. Zakaz kampienia w Medyku oraz GR.");
		PrintToChat(client,"\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 4. Mozna tworzyc maksymalnie trzyosobowe sojusze.");
		PrintToChat(client,"\x01[\x04Zabawy - Killday\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	} else
	if(numerZabawy==3)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 1. Przez pierwsze 30 sekund zabawy Straznicy maja zakaz wychodzenia z GR, a Wiezniowie rozbiegaja sie po mapie.");
		PrintToChat(client,"\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 2. Po tym czasie Straznicy wybiegaja z GR i probuja zabic Wiezniow przy uzyciu noza.");
		PrintToChat(client,"\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 3. Zarowno Straznicy jak i Wiezniowie maja zablokowana mozliwosc podnoszenia broni palnej.");
		PrintToChat(client,"\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 4. Wiezniowie maja zakaz kampienia w jednym miejscu - musza biegac po mapie!");
		PrintToChat(client,"\x01[\x04Zabawy - Ganiany\x01] \x02ZASADY:\x01 5. Ostatni wiezien MA ZYCZENIE.");
	} else
	if(numerZabawy==4)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 1. Przez pierwsze 60 sekund Straznicy maja zakaz opuszczania GR.");
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 2. W tym czasie Wiezniowie rozbiegaja sie po mapie w poszukiwaniu kryjowki, po minucie robi sie ciemno.");
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 3. Wiezniowie maja kategoryczny zakaz chowania sie poza teksturami mapy.");	
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 4. Po wyznaczonym czasie Wiezniowie maja bezruch, a Straznicy probuja ich znalezc.");
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 5. Gdy Straznik znajdzie Wieznia, musi go zabic.");
		PrintToChat(client,"\x01[\x04Zabawy - Chowany\x01] \x02ZASADY:\x01 6. Ostatni wiezien MA ZYCZENIE.");
	} else
	if(numerZabawy==5)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 1. Wiezniowie zostaja podzieleni na trzy do pieciu druzyn: Niebieska, Zielona i Czerwona oraz Zolci i Fioletowi.");
		PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 2. Po minucie zostaje wlaczony box, a druzyny walcza miedzy soba.");
		PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 3. Gdy przy zyciu zostanie tylko jedna druzyna, jej czlonkowie walcza miedzy soba.");
		PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 4. Zakaz kampienia w GR oraz Medyku.");
		PrintToChat(client,"\x01[\x04Zabawy - Wojny Gangow\x01] \x02ZASADY:\x01 5. Ostatni wiezien MA ZYCZENIE.");
	} else
	if(numerZabawy==6)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 1. Przez pierwsze 30 sekund wszyscy gracze rozbiegaja sie po mapie.");
		PrintToChat(client,"\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 2. Po tym czasie kazdy otrzymuje Decoya, ktorym stara sie trafic przeciwnika.");
		PrintToChat(client,"\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 3. Trafienie wroga granatem oznacza jego natychmiastowa smierc.");
		PrintToChat(client,"\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 4. Zabawa trwa do ostatniej zywej osoby - jest to zabawa DLA WSZYSTKICH.");
		PrintToChat(client,"\x01[\x04Zabawy - zbikaj\x01] \x02ZASADY:\x01 5. Mozna tworzyc maksymalnie trzyosobowe sojusze.");
		PrintToChat(client,"\x01[\x04Zabawy - Zbijak\x01] \x02ZASADY:\x01 6. Ostatni wiezien NIE MA zyczenia.");
	}
	if(numerZabawy==8)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 1. Zabawa polega na unikaniu terrorysty z bomba.");
		PrintToChat(client,"\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 2. Po rozpoczeciu zabawy, terrorysci maja 30 sekund na rozbiegniecie sie po mapie.");
		PrintToChat(client,"\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 3. Co 15 sekund bomba wybucha, raniac przy tym osoby w poblizu.");
		PrintToChat(client,"\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 4. Jezeli trzymasz bombe, musisz ja komus jak najszybciej podrzucic.");
		PrintToChat(client,"\x01[\x04Zabawy - Abdul Terrorysta\x01] \x02ZASADY:\x01 5. Ostatni wiezien MA ZYCZENIE.");
	}
	if(numerZabawy==9)
	{
		PrintToChat(client,"\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 1. Po rozpoczeciu zabawy, gracze maja 30 sekund na rozbiegniecie sie po mapie.");
		PrintToChat(client,"\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 2. Po tym czasie kazdy otrzymuje Zeusa i stara sie zabic przeciwnikow."); // P\x01o \x02t\x03y\x04m \x05c\x06z\x07a\x08s\x09i\x10e \x0Bk\x0Ca\x0Ezdy otrzymuje Zeusa i stara sie zabic przeciwnikow.");
		PrintToChat(client,"\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 3. Kazdy z graczy otrzymuje wieksza predkosc, mniejsza grawitacje oraz dodatkowe HP.");
		PrintToChat(client,"\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 4. Zabawa trwa do ostatniej zywej osoby - jest to zabawa DLA WSZYSTKICH.");
		PrintToChat(client,"\x01[\x04Zabawy - Zeus War\x01] \x02ZASADY:\x01 5. Ostatni wiezien NIE MA zyczenia.");
	}
}
public OnMapStart()
{
	g_HaloSprite = PrecacheModel( "sprites/halo01.vmt" );
	g_ExplosionSprite = PrecacheModel( "sprites/sprite_fire01.vmt" );

	new ent; 
	ent = FindEntityByClassname(-1, "env_fog_controller");
	if (ent != -1) 
	{
		FogIndex = ent;
	}
	else
	{
		FogIndex = CreateEntityByName("env_fog_controller");
		DispatchSpawn(FogIndex);
	}
	DoFog();
	AcceptEntityInput(FogIndex, "TurnOff");
	handleminuta=INVALID_HANDLE;
	handlepol1=INVALID_HANDLE;
	handlepol2=INVALID_HANDLE;
	handlel1=INVALID_HANDLE;
	handlekd1=INVALID_HANDLE;
	handlekd2=INVALID_HANDLE;
	handlekd3=INVALID_HANDLE;
	handlel2=INVALID_HANDLE;
	handlegn1=INVALID_HANDLE;
	handlegn2=INVALID_HANDLE;
	handlel3=INVALID_HANDLE;
	handlech1=INVALID_HANDLE;
	handlech2=INVALID_HANDLE;
	handlel4=INVALID_HANDLE;
	handlewg1=INVALID_HANDLE;
	handlewg2=INVALID_HANDLE;
	handlewg3=INVALID_HANDLE;
	handlel5=INVALID_HANDLE;
	handlez1=INVALID_HANDLE;
	handlez2=INVALID_HANDLE;
	handlel6=INVALID_HANDLE;
	handlezab1=INVALID_HANDLE;
	handlezab2=INVALID_HANDLE
	handlezab3=INVALID_HANDLE;
	handleabdul=INVALID_HANDLE;
	handlezeus=INVALID_HANDLE;
	chowanyStart = 0;
	
	koniecAbdul = 0;
	startAbdul = 0;
	
	numPrinted = 30;
	numPrinted2 = -1;
	bomba = 0;
	
	startZeus = 0;
	koniecZeus = 0;
	checkZeus = 0;
	numPrinted3 = 30;
	
	Abdul = 0;
	
	if(MyZeusOdliczanie!=INVALID_HANDLE)
	{
		KillTimer(MyZeusOdliczanie);
		MyZeusOdliczanie=INVALID_HANDLE
	}
	
	if(handlezeus!=INVALID_HANDLE)
	{
		KillTimer(handlezeus);
		handlezeus=INVALID_HANDLE
	}
	
	g_fire = PrecacheModel("materials/sprites/fire2.vmt");
	g_HaloSprite = PrecacheModel("materials/sprites/halo01.vmt");
	g_ExplosionSprite = PrecacheModel("sprites/sprite_fire01.vmt");
	PrecacheSound(SOUND_BOOM, true);
	
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
	if(MyGiveZeus2!=INVALID_HANDLE)
	{
		KillTimer(MyGiveZeus2);
		MyGiveZeus2=INVALID_HANDLE;
	}
	
	
}
public OnMapEnd()
{
	UsunZabawe();
	licznik=0;
	byla[0]=false;
	byla[1]=false;
	byla[2]=false;
	byla[3]=false;
	byla[4]=false;
	byla[5]=false;
	byla[6]=false;
	byla[8]=false;
	byla[9]=false;
	minuta=false;
	debugZabaw=false;
	chowanyStart = 0;
	
	koniecAbdul = 1;
	startAbdul = 0;
	
	startZeus = 0;
	koniecZeus = 0;
	checkZeus = 0;
	numPrinted3 = 30;
	
	numPrinted = 30;
	numPrinted2 = -1;
	bomba = 0;
	
	Abdul = 0;
	
	if(MyZeusOdliczanie!=INVALID_HANDLE)
	{
		KillTimer(MyZeusOdliczanie);
		MyZeusOdliczanie=INVALID_HANDLE
	}
	
	if(handlezeus!=INVALID_HANDLE)
	{
		KillTimer(handlezeus);
		handlezeus=INVALID_HANDLE
	}
	
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
	if(MyGiveZeus2!=INVALID_HANDLE)
	{
		KillTimer(MyGiveZeus2);
		MyGiveZeus2=INVALID_HANDLE;
	}
}
public Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(handleminuta!=INVALID_HANDLE)
	{
		KillTimer(handleminuta);
		handleminuta=INVALID_HANDLE;
	}
	handleminuta=CreateTimer(60.0,MinutaNaWlaczenie,_,TIMER_FLAG_NO_MAPCHANGE);
	
	for(new iGiveZE2 = 1; iGiveZE2<=MaxClients; iGiveZE2++)
	{
		if(IsClientInGame(iGiveZE2) && IsPlayerAlive(iGiveZE2))
		{
			gravity(iGiveZE2, 1.0);
			speed(iGiveZE2, 1.0);
		}
	}
	
}
public Event_RoundFreezeEnd(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(handlezab1!=INVALID_HANDLE)
	{
		KillTimer(handlezab1);
		handlezab1=INVALID_HANDLE;
	}
	timerr=(GetConVarInt(FindConVar("mp_roundtime"))*60)-7;
	handlezab1=CreateTimer(1.0,OdliczajDoKonca,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	if(debugZabaw==true)
	{
		if(uid!=0)
		{
			new client=GetClientOfUserId(uid);
			PrintToChat(client," \x0ESprawdz konsole, nowe dane debugu.");
			PrintToConsole(client,"\n**** Zabawy 1.5.2 ****\nKoniec freezetime - uruchomiono timer OdliczajDoKonca na %ds.\n**********************\n",timerr);
		}
	}
}
public Action:OdliczajDoKonca(Handle:timer)
{
	if(timerr>0)
	{
		timerr--;
		if(debugZabaw==true)
		{
			if(uid!=0)
			{
				new client=GetClientOfUserId(uid);
				PrintHintText(client,"Debug: OdliczajDoKonca %d sekund.",timerr);
			}
		}
	} else
	{
		KillTimer(handlezab1);
		handlezab1=INVALID_HANDLE;
		if(numerZabawy==6 || numerZabawy==2 || numerZabawy==8 || numerZabawy==9)
		{
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
			odliczanie=5.0;
			handlezab2=CreateTimer(0.1,KoniecInfo,_,TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
			handlezab3=CreateTimer(5.2,Koniec,_,TIMER_FLAG_NO_MAPCHANGE);
		}
	}
}
public Action:KoniecInfo(Handle:timer)
{
	if(odliczanie>0)
	{
		PrintHintTextToAll("        Runda zakonczy sie za:\n <font size='40' color='#009900'>    %0.1f sekund</font>",odliczanie);
		odliczanie=odliczanie-0.1;
		if(odliczanie<0.2 && odliczanie>0.0)
		{
			ServerCommand("mp_teammates_are_enemies 0");
			ServerCommand("mp_ignore_round_win_conditions 0");
		}
	} else
	{
		if(handlezab2!=INVALID_HANDLE)
		{
			KillTimer(handlezab2);
			handlezab2=INVALID_HANDLE;
		}
	}
}
public Action:Koniec(Handle:timer)
{
	new iCounter;
	PrintHintTextToAll("Runda sie skonczyla, wszyscy zostaja zgladzeni.");
	for (new i=1; i<=GetMaxClients(); i++)
	{
		if (IsClientInGame(i) && !IsClientObserver(i) && IsPlayerAlive(i))
		{
			iCounter++;
			new deaths = GetEntProp(i, Prop_Data, "m_iDeaths");
			SetEntProp(i, Prop_Data, "m_iDeaths", deaths-1);
			new kills = GetEntProp(i, Prop_Data, "m_iFrags");
			SetEntProp(i, Prop_Data, "m_iFrags", kills+1);
			ForcePlayerSuicide(i);
		}
	}
	handlezab3=INVALID_HANDLE;
	if(iCounter == 0)
	{
		CS_TerminateRound(3.5, CSRoundEnd_CTWin, false);
	}
}

public Action:CS_OnTerminateRound(&Float:delay, &CSRoundEndReason:reason)
{
	return Plugin_Changed;
}

public Action:MinutaNaWlaczenie(Handle:timer)
{
	minuta=true;
	handleminuta=INVALID_HANDLE;
}
public Event_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast)
{
	UsunZabawe();
	if(handleminuta!=INVALID_HANDLE)
	{
		KillTimer(handleminuta);
		handleminuta=INVALID_HANDLE;
	}
	minuta=false;
}
public OnClientDisconnect(client)
{
	SDKUnhook(client, SDKHook_OnTakeDamage,OnTakeDamage);
	SDKUnhook(client, SDKHook_WeaponCanUse,OnWeaponCanUse);
	SDKUnhook(client, SDKHook_TraceAttack,TraceAttack);
	SDKUnhook(client, SDKHook_WeaponEquip, OnWeaponEquip);
	SDKUnhook(client, SDKHook_WeaponDrop, OnWeaponDrop);
	decl String:steamid[32];
	GetClientAuthId(client,AuthId_Steam2,steamid,sizeof(steamid));
	if(strcmp(steamid,"STEAM_1:1:24982202",true)==0)
	{
		uid=0;
	}
}
public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype, &weapon, Float:damageForce[3], Float:damagePosition[3])
{
	if(wlaczona==true)
	{
		if(numerZabawy==1)
		{
			if(polowanieZaczeta==false)
			{
				if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
				{
					damage=0.0;
					return Plugin_Changed;
				}
			} else
			if(polowanieZaczeta==true)
			{
				decl String:sWeapon[32];
				if(weapon!=-1)
				{
					GetEntityClassname(weapon, sWeapon, sizeof(sWeapon));
				}
				if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT && GetClientTeam(attacker)==CS_TEAM_T)
				{
					if(weapon==-1)
					{
						damage=0.0;
						return Plugin_Changed;
					} else
					if(!(StrEqual(sWeapon, "weapon_knife")))
					{
						damage=0.0;
						return Plugin_Changed;
					}
				}
				if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_T && GetClientTeam(attacker)==CS_TEAM_CT)
				{
					if(weapon==-1)
					{
						damage=0.0;
						return Plugin_Changed;
					} else
					if(!(StrEqual(sWeapon, "weapon_awp")))
					{
						damage=0.0;
						return Plugin_Changed;
					}
				}
			}
		} else
		if(numerZabawy==2)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)!=GetClientTeam(attacker))
			{
				damage=0.0;
				return Plugin_Changed;
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==3)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				damage=0.0;
				return Plugin_Changed;
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==4)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				damage=0.0;
				return Plugin_Changed;
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==5)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)!=GetClientTeam(attacker))
			{
				damage=0.0;
				return Plugin_Changed;
			} else
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				damage=0.0;
				return Plugin_Changed;
			} else
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(attacker)==CS_TEAM_T && GetClientTeam(victim)==CS_TEAM_T)
			{
				if(JedenGang==false && user_gangi[attacker] == user_gangi[victim])
				{
					damage=0.0;
					return Plugin_Changed;
				} else
				if(JedenGang==true && user_gangi[attacker] == user_gangi[victim])
					return Plugin_Continue;
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==6)
		{
			if(zbijakZaczety==false)
			{
				if(IsValidPlayer(victim) && IsValidPlayer(attacker))
				{
					damage=0.0;
					return Plugin_Changed;
				}
			} else
			if(zbijakZaczety==true)
			{
				decl String:sWeapon[32];
				GetEdictClassname(inflictor, sWeapon, sizeof(sWeapon));
				if(StrEqual(sWeapon, "weapon_decoy") || StrEqual(sWeapon, "decoy_projectile"))
				{
					damage=2000.0;
					return Plugin_Changed;
				} else
				if(IsValidPlayer(victim) && IsValidPlayer(attacker))
				{
					damage=0.0;
					return Plugin_Changed;
				}
			}
			return Plugin_Continue;
		}	else
		if(numerZabawy==8)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker))
			{
				damage=0.0;
				return Plugin_Changed;
			}
			return Plugin_Continue;
		}
		if(numerZabawy==9)
		{
			if(checkZeus == 0)
			{	
				if(IsValidPlayer(victim) && IsValidPlayer(attacker))
				{
					damage=0.0;
					return Plugin_Changed;
				}
			} else
			if(checkZeus == 1)
			{
				decl String:sWeapon[32];
				GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
				if(StrEqual(sWeapon, "weapon_taser"))
				{
					new ammo;
					ammo = GetEntData(weapon, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"));
					if(ammo == 0)
					{
						damage=damage;
						return Plugin_Changed;
					}
					if(ammo == 1)
					{
						damage = damage;
						return Plugin_Changed;
					}
					if(ammo == 2)
					{
						damage=damage / 2;
						return Plugin_Changed;
					}
					if(ammo == 3)
					{
						damage=damage / 4;
						return Plugin_Changed;
					}
				} else
				if(IsValidPlayer(victim) && IsValidPlayer(attacker))
				{
					damage=0.0;
					return Plugin_Changed;
				}
			}
			return Plugin_Continue;
		}
	}
	return Plugin_Continue;
}
public Action:TraceAttack(victim, &attacker, &inflictor, &Float:damage, &damagetype, &ammotype, hitbox, hitgroup)
{
	if(wlaczona==true)
	{
		if(numerZabawy==1)
		{
			if(polowanieZaczeta==false)
			{
				if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
				{
					return Plugin_Handled;
				} else return Plugin_Continue;
			}
		} else
		if(numerZabawy==2)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)!=GetClientTeam(attacker))
			{
				return Plugin_Handled;
			} else return Plugin_Continue;
		} else
		if(numerZabawy==3)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				return Plugin_Handled;
			} else return Plugin_Continue;
		} else
		if(numerZabawy==4)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				return Plugin_Handled;
			} else return Plugin_Continue;
		} else
		if(numerZabawy==5)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)!=GetClientTeam(attacker))
			{
				return Plugin_Handled;
			} else
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(victim)==CS_TEAM_CT)
			{
				return Plugin_Handled;
			} else
			if(IsValidPlayer(victim) && IsValidPlayer(attacker) && GetClientTeam(attacker)==CS_TEAM_T && GetClientTeam(victim)==CS_TEAM_T)
			{
				if(JedenGang==false && user_gangi[attacker] == user_gangi[victim])
				{
					return Plugin_Handled;
				} else
				if(JedenGang==true && user_gangi[attacker] == user_gangi[victim])
					return Plugin_Continue;
			} else return Plugin_Continue;
		}	else
		if(numerZabawy==8)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker))
			{
				return Plugin_Handled;
			} else return Plugin_Continue;
		}	else
		if(numerZabawy==6 || numerZabawy==9)
		{
			if(IsValidPlayer(victim) && IsValidPlayer(attacker))
			{
				if(damagetype == DMG_BULLET)
				{
					return Plugin_Handled;
				}
				else
				{
					return Plugin_Continue;
				}
			} else return Plugin_Continue;
		}
	}
	return Plugin_Continue;
}
public Action:OnWeaponCanUse(client, weapon)
{
	if(wlaczona==true)
	{
		if(numerZabawy==1)
		{
			decl String:sWeapon[32];  
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));  
			if(!StrEqual(sWeapon,"weapon_knife") && GetClientTeam(client)==CS_TEAM_T)
			{  
				return Plugin_Handled;  
			} else
			if(!StrEqual(sWeapon,"weapon_awp") && !StrEqual(sWeapon,"weapon_knife") && GetClientTeam(client)==CS_TEAM_CT)
			{
					return Plugin_Handled;
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==3)
		{
			decl String:sWeapon[32];
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
			if(GetClientTeam(client)==CS_TEAM_CT || GetClientTeam(client)==CS_TEAM_T)
			{
				if(!StrEqual(sWeapon,"weapon_knife"))
				{
					return Plugin_Handled; 
				}
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==4)
		{
			decl String:sWeapon[32];
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
			if(GetClientTeam(client)!=CS_TEAM_CT)
			{
				if(!StrEqual(sWeapon,"weapon_knife"))
				{
					return Plugin_Handled;
				}
			}
			return Plugin_Continue;
		} else
		if(numerZabawy==6)
		{
			decl String:sWeapon[32];  
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));  
			if(!StrEqual(sWeapon,"weapon_decoy") && !StrEqual(sWeapon,"weapon_knife"))
			{  
				return Plugin_Handled;  
			}     
			return Plugin_Continue;  
		}	else
		if(numerZabawy==8)
		{
			decl String:sWeapon[32];  
			GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
			if(GetClientTeam(client)!=CS_TEAM_CT)
				{			
				if(!StrEqual(sWeapon,"weapon_c4"))
				{ 
					return Plugin_Handled;
				}
			}
			return Plugin_Continue; 
		}
		if(numerZabawy==9)
		{
			if(checkZeus == 1)
			{
				decl String:sWeapon[32];  
				GetEdictClassname(weapon, sWeapon, sizeof(sWeapon)); 
				if(!StrEqual(sWeapon,"weapon_taser") && !StrEqual(sWeapon,"weapon_knife")) //!StrEqual(sWeapon,"weapon_decoy")
				{ 
					return Plugin_Handled;
				}
				return Plugin_Continue; 
			}
			else
			{
				decl String:sWeapon[32];  
				GetEdictClassname(weapon, sWeapon, sizeof(sWeapon));
				if(!StrEqual(sWeapon,"weapon_taser") && !StrEqual(sWeapon,"weapon_knife")) //!StrEqual(sWeapon,"weapon_decoy")
				{ 
					return Plugin_Handled;
				}
				return Plugin_Continue; 
			}
		}
	}
	return Plugin_Continue;
}
public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	if(wlaczona==true)
	{
		if(numerZabawy==2)
		{
			new iloscZywych[2]={0,0};
			for(new i=1; i<=GetMaxClients(); i++)
			{
				if(IsClientInGame(i) && IsPlayerAlive(i))
				{
					if(GetClientTeam(i)==CS_TEAM_CT)
						iloscZywych[0]++;
					if(GetClientTeam(i)==CS_TEAM_T)
						iloscZywych[1]++;
				}
			}
			if(iloscZywych[0]==1 && iloscZywych[1]==1)
			{
				for(new i=1;i<=GetMaxClients();i++)
				{
					if(IsClientInGame(i) && IsPlayerAlive(i))
					{
						SDKUnhook(i, SDKHook_OnTakeDamage,OnTakeDamage);
						SDKUnhook(i, SDKHook_TraceAttack,TraceAttack);
					}
				}
				UsunZabawe();
				PrintHintTextToAll("Przy zyciu zostal 1 TT i 1 CT.\n\n<font color='#009900'>Bijecie sie miedzy soba!</font>");
				wlaczona=false;
			}
			if(iloscZywych[0]==1 && iloscZywych[1]==0 || iloscZywych[0]==0 && iloscZywych[1]==1)
			{
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
		} else
		if(numerZabawy==3)
		{
			decl String:nickname[65];
			new iloscZywych=0;
			for(new i=1; i<=GetMaxClients(); i++)
			{
				if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
				{
					iloscZywych++;
					GetClientName(i,nickname,sizeof(nickname));
				}
			}
			if(iloscZywych==1)
			{
				UsunZabawe();
				new userid = GetClientOfUserId(GetEventInt(event, "userid")); 
				if(GetClientTeam(userid)==CS_TEAM_T)
					PrintHintTextToAll("<font color='#009900'>%s</font> zostal ostatnim wiezniem!\nPrzysluguje mu zyczenie!",nickname);
			}
		} else
		if(numerZabawy==4)
		{	
			new client=GetClientOfUserId(GetEventInt(event,"userid"));
			if(GetEntityFlags(client) & FL_ATCONTROLS)
			{
				SetEntityFlags(client,GetEntityFlags(client)^FL_ATCONTROLS);
			}			
			decl String:nickname[65];
			new iloscZywych=0;
			for(new i=1; i<=GetMaxClients(); i++)
			{
				if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
				{
					iloscZywych++;
					GetClientName(i,nickname,sizeof(nickname));
				}
			}
			if(iloscZywych==1)
			{
				UsunZabawe();
				new userid = GetClientOfUserId(GetEventInt(event, "userid")); 
				if(GetClientTeam(userid)==CS_TEAM_T)
					PrintHintTextToAll("<font color='#009900'>%s</font> zostal ostatnim wiezniem!\nPrzysluguje mu zyczenie!",nickname);
			}
		} else
		if(numerZabawy==5)
		{
			new userid = GetClientOfUserId(GetEventInt(event, "userid"));
			decl String:nickname[65];
			new iloscZywych=0;
			if(handlewg2==INVALID_HANDLE)
			{
				new gang[5];
				for(new i=1; i<=GetMaxClients(); i++)
				{
					if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
					{
						gang[user_gangi[i]]++;
						iloscZywych++;
						GetClientName(i,nickname,sizeof(nickname));
					}
				}
				if(GetClientTeam(userid)==CS_TEAM_T)
				{
					if(gang[0] == 0)
					{
						kolor0 = "";
					}
					else
					{
						IntToString(gang[0], gang0, 8);
						kolor0 = "Czerwony: ";
						StrCat(kolor0, sizeof(kolor0), gang0);
						if(gang[1] > 0 || gang[2] > 0 || gang[3] > 0 || gang[4] > 0)
						{
							StrCat(kolor0, sizeof(kolor0), przecinek);
						}
					}
					
					if(gang[1] == 0)
					{
						kolor1 = "";
					}
					else
					{
						IntToString(gang[1], gang1, 8);
						kolor1 = "Zielony: ";
						StrCat(kolor1, sizeof(kolor1), gang1);
						if(gang[2] > 0 || gang[3] > 0 || gang[4] > 0)
						{
							StrCat(kolor1, sizeof(kolor1), przecinek);
						}
					}
					
					if(gang[2] == 0)
					{
						kolor22 = "";
					}
					else
					{
						IntToString(gang[2], gang2, 8);
						kolor22 = "Niebieski: ";
						StrCat(kolor22, sizeof(kolor22), gang2);
						if(gang[3] > 0 || gang[4] > 0)
						{
							StrCat(kolor22, sizeof(kolor22), przecinek);
						}
					}
					
					if(gang[3] == 0)
					{
						kolor3 = "";
					}
					else
					{
						IntToString(gang[3], gang3, 8);
						kolor3 = "Zolty: ";
						StrCat(kolor3, sizeof(kolor3), gang3);
						if(gang[4] > 0)
						{
							StrCat(kolor3, sizeof(kolor3), przecinek);
						}
					}
					
					if(gang[4] == 0)
					{
						kolor4 = "";
					}
					else
					{
						IntToString(gang[4], gang4, 8);
						kolor4 = "Fioletowy: ";
						StrCat(kolor4, sizeof(kolor4), gang4);
					}
					
					PrintToChatAll("\x01[\x04Zabawy - Wojny Gangow\x01] \x07%s\x04%s\x0C%s\x09%s\x03%s\x01%s",kolor0, kolor1, kolor22, kolor3, kolor4, kropka);
				}
				if((gang[0]==0 && gang[1]==0 && gang[2]>0 && gang[3]==0 && gang[4]==0) || (gang[0]>0 && gang[1]==0 && gang[2]==0 && gang[3]==0 && gang[4]==0) || (gang[0]==0 && gang[1]>0 && gang[2]==0 && gang[3]==0 && gang[4]==0) || (gang[0]==0 && gang[1]==0 && gang[2]==0 && gang[3]>0 && gang[4]==0) || (gang[0]==0 && gang[1]==0 && gang[2]==0 && gang[3]==0 && gang[4]>0))
				{
					JedenGang=true;
					if(GetClientTeam(userid)==CS_TEAM_T && JedenGangInfo==false)
					{
						PrintHintTextToAll("Przy zyciu zostala tylko jeden gang.\n<font color='#009900'>Bijecie sie miedzy soba!</font>");
						JedenGangInfo=true;
					}
				}
				if(iloscZywych==1)
				{
					UsunZabawe();
					if(GetClientTeam(userid)==CS_TEAM_T)
						PrintHintTextToAll("<font color='#009900'>%s</font> zostal ostatnim wiezniem!\nPrzysluguje mu zyczenie!",nickname);
				}
			}
		} else
		if(numerZabawy==6)
		{
			new iloscZywych=0;
			for(new i=1; i<=GetMaxClients(); i++)
			{
				if(IsClientInGame(i) && IsPlayerAlive(i))
				{
					iloscZywych++;
				}
			}
			if(iloscZywych==1)
			{
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
}
public Action:UsunZabawe()
{
	if(handlepol1!=INVALID_HANDLE)
	{
		KillTimer(handlepol1);
		handlepol1=INVALID_HANDLE;
	}
	if(handlepol2!=INVALID_HANDLE)
	{
		KillTimer(handlepol2);
		handlepol2=INVALID_HANDLE;
	}				
	if(handlel1!=INVALID_HANDLE)
	{
		KillTimer(handlel1);
		handlel1=INVALID_HANDLE;
	}
	if(handlekd1!=INVALID_HANDLE)
	{
		KillTimer(handlekd1);
		handlekd1=INVALID_HANDLE;
	}
	if(handlekd2!=INVALID_HANDLE)
	{
		KillTimer(handlekd2);
		handlekd2=INVALID_HANDLE;
	}
	if(handlekd3!=INVALID_HANDLE)
	{
		KillTimer(handlekd3);
		handlekd3=INVALID_HANDLE;
	}
	if(handlel2!=INVALID_HANDLE)
	{
		KillTimer(handlel2);
		handlel2=INVALID_HANDLE;
	}
	if(handlegn1!=INVALID_HANDLE)
	{
		KillTimer(handlegn1);
		handlegn1=INVALID_HANDLE;
	}
	if(handlegn2!=INVALID_HANDLE)
	{
		KillTimer(handlegn2);
		handlegn2=INVALID_HANDLE;
	}
	if(handlel3!=INVALID_HANDLE)
	{
		KillTimer(handlel3);
		handlel3=INVALID_HANDLE;
	}
	if(handlech1!=INVALID_HANDLE)
	{
		KillTimer(handlech1);
		handlech1=INVALID_HANDLE;
	}
	if(handlech2!=INVALID_HANDLE)
	{
		KillTimer(handlech2);
		handlech2=INVALID_HANDLE;
	}
	if(handlel4!=INVALID_HANDLE)
	{
		KillTimer(handlel4);
		handlel4=INVALID_HANDLE;
	}
	if(handlewg1!=INVALID_HANDLE)
	{
		KillTimer(handlewg1);
		handlewg1=INVALID_HANDLE;
	}
	if(handlewg2!=INVALID_HANDLE)
	{
		KillTimer(handlewg2);
		handlewg2=INVALID_HANDLE;
	}
	if(handlewg3!=INVALID_HANDLE)
	{
		KillTimer(handlewg3);
		handlewg3=INVALID_HANDLE;
	}
	if(handlel5!=INVALID_HANDLE)
	{
		KillTimer(handlel5);
		handlel5=INVALID_HANDLE;
	}
	if(handlez1!=INVALID_HANDLE)
	{
		KillTimer(handlez1);
		handlez1=INVALID_HANDLE;
	}
	if(handlez2!=INVALID_HANDLE)
	{
		KillTimer(handlez2);
		handlez2=INVALID_HANDLE;
	}
	if(handlel6!=INVALID_HANDLE)
	{
		KillTimer(handlel6);
		handlel6=INVALID_HANDLE;
	}
	if(handlezab1!=INVALID_HANDLE)
	{
		KillTimer(handlezab1);
		handlezab1=INVALID_HANDLE;
	}
	if(handlezab2!=INVALID_HANDLE)
	{
		KillTimer(handlezab2);
		handlezab2=INVALID_HANDLE
	}
	if(handlezab3!=INVALID_HANDLE)
	{
		KillTimer(handlezab3);
		handlezab3=INVALID_HANDLE;
	}
	if(handleabdul!=INVALID_HANDLE)
	{
		KillTimer(handleabdul);
		handleabdul=INVALID_HANDLE;
	}
	if(handlezeus!=INVALID_HANDLE)
	{
		KillTimer(handlezeus);
		handlezeus=INVALID_HANDLE;
	}
	wlaczona=false;
	polowanieZaczeta=false;
	zbijakZaczety=false;
	JedenGang=false;
	JedenGangInfo=false;
	ServerCommand("mp_teammates_are_enemies	0");
	ServerCommand("mp_friendlyfire 0");
	ServerCommand("mp_ignore_round_win_conditions 0");
	ServerCommand("sv_gravity 800");
	ServerCommand("sv_infinite_ammo 0");
	ServerCommand("sv_ignoregrenaderadio 0");
	licznikGangow={0,0,0,0,0};
	fogoff();
	timer1=60;
	timer2=60;
	timer3=30;
	timer4=60;
	timer5=60;
	timer6=30;
	for(new i=1;i<GetMaxClients();i++)
	{
		SDKUnhook(i, SDKHook_OnTakeDamage,OnTakeDamage);
		SDKUnhook(i, SDKHook_WeaponCanUse,OnWeaponCanUse);
		SDKUnhook(i, SDKHook_TraceAttack,TraceAttack);
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			if(GetClientTeam(i)==CS_TEAM_T)
				SetEntityRenderColor(i, 255, 255, 255, 255);
			SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue",1.0);
			if(GetEntityFlags(i) & FL_ATCONTROLS)
			{
				SetEntityFlags(i, GetEntityFlags(i)^FL_ATCONTROLS);
			}
		}
	}
	numerZabawy=0;
	chowanyStart = 0;
	numerZabawy=0;
	startAbdul = 0;
		
	numPrinted = 30;
	numPrinted2 = -1;
	bomba = 0;
	
	Abdul = 0;
	
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
	if(MyGiveZeus2!=INVALID_HANDLE)
	{
		KillTimer(MyGiveZeus2);
		MyGiveZeus2=INVALID_HANDLE;
	}
	
	startZeus = 0;
	koniecZeus = 0;

	checkZeus = 0;

	numPrinted3 = 30;
	
	if(MyZeusOdliczanie!=INVALID_HANDLE)
	{
		KillTimer(MyZeusOdliczanie);
		MyZeusOdliczanie=INVALID_HANDLE
	}
	
	
	if(handlezeus!=INVALID_HANDLE)
	{
		KillTimer(handlezeus);
		KillTimer(handlezeus);
		handlezeus=INVALID_HANDLE
	}

}
public Action:AnulujZabawe(client,args)
{
	decl String:name[65];
	GetClientName(client,name,sizeof(name));
	if(handlepol1!=INVALID_HANDLE || handlekd2!=INVALID_HANDLE || handlegn1!=INVALID_HANDLE || handlech1!=INVALID_HANDLE || handlewg2!=INVALID_HANDLE || handlez1!=INVALID_HANDLE || handleabdul!=INVALID_HANDLE || handlezeus!=INVALID_HANDLE)
	{
		byla[numerZabawy]=false;
		licznik--;
		for(new i=1;i<GetMaxClients();i++)
			if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
			{
				SetEntProp(i, Prop_Data, "m_iFOV", 0);
				Client_RemoveAllWeapons(i,"weapon_knife",true);
			}
		UsunZabawe();
		LogAction(client, -1,"ADMIN \"%L\" anulowal zabawe.",client);
		PrintHintTextToAll("<font color='#FF0000'>Admin %s zadecydowal o anulowaniu zabawy!</font>\nWylaczono wszystkie funkcje zabaw.</font>",name);
	} else 
	if(client>0)
		PrintToChat(client,"\x01[\x04JailBreak\x01] Zabawa nie jest wlaczona, lub nie jest juz w fazie odliczania. Nie mozesz jej anulowac.");
}
public Event_PlayerSpawn(Handle:event,const String:name[],bool:dontBroadcast)
{
	new client=GetClientOfUserId(GetEventInt(event, "userid"));
	FroggyJumped[client] = 0;
	FroggyJump[client] = false;
	if(wlaczona==true && numerZabawy==1)
	{
		if(GetClientTeam(client)==CS_TEAM_T || GetClientTeam(client)==CS_TEAM_CT)
		{
			SetEntProp(client, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(client,"weapon_knife",true);
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_TraceAttack, TraceAttack);
			SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
			if(GetClientTeam(client)==CS_TEAM_CT)
				GivePlayerItem(client,"weapon_awp");
		}
	} else
	if(wlaczona==true && numerZabawy==2)
	{
		if(handlekd1==INVALID_HANDLE && (GetClientTeam(client)==CS_TEAM_T || GetClientTeam(client)==CS_TEAM_CT))
		{
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_TraceAttack, TraceAttack);
			KilldayMenu1(client);
			SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
			GivePlayerItem(client, "item_assaultsuit");
			SetEntProp(client,Prop_Send,"m_ArmorValue",100,1);
			GivePlayerItem(client,"weapon_hegrenade");
			if(GetUserFlagBits(client) & ADMFLAG_CUSTOM6)
			{
				GivePlayerItem(client,"weapon_flashbang");
				GivePlayerItem(client,"weapon_smokegrenade");
				GivePlayerItem(client, "item_heavyassaultsuit");
				SetEntProp(client,Prop_Send,"m_ArmorValue",200,1);
			}
		}
	} else
	if(wlaczona==true && numerZabawy==3)
	{
		if(GetClientTeam(client)==CS_TEAM_CT)
		{
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_TraceAttack, TraceAttack);
			SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
			SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue",1.65);
			SetEntProp(client, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(client,"weapon_knife",true);
		} else
		if(GetClientTeam(client)==CS_TEAM_T)
		{
			SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue",1.6);
			SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
			SetEntProp(client, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(client,"weapon_knife",true);
			SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		}
	} else
	if(wlaczona==true && numerZabawy==4)
	{
		if(GetClientTeam(client)==CS_TEAM_CT)
		{
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_TraceAttack, TraceAttack);
		} else
		if(GetClientTeam(client)==CS_TEAM_T)
		{
			if(handlech1==INVALID_HANDLE && !(GetEntityFlags(client) & FL_ATCONTROLS))
				SetEntityFlags(client, GetEntityFlags(client)^FL_ATCONTROLS);
			SetEntProp(client, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(client,"weapon_knife",true);
			SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
			SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		}
	} else
	if(wlaczona==true && numerZabawy==5)
	{
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		SDKHook(client, SDKHook_TraceAttack, TraceAttack);
		if(GetClientTeam(client)==CS_TEAM_T && handlewg1==INVALID_HANDLE)
		{
			SprawdzDruzyny(client);
			WojnyGangowMenu1(client);
			SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
			GivePlayerItem(client, "item_assaultsuit");
			SetEntProp(client,Prop_Send,"m_ArmorValue",100,1);
			GivePlayerItem(client,"weapon_hegrenade");
			if(GetUserFlagBits(client) & ADMFLAG_CUSTOM6)
			{
				GivePlayerItem(client,"weapon_flashbang");
				GivePlayerItem(client,"weapon_smokegrenade");
				GivePlayerItem(client, "item_heavyassaultsuit");
				SetEntProp(client,Prop_Send,"m_ArmorValue",200,1);
			}
		}
	} else
	if(wlaczona==true && numerZabawy==6)
	{
		if(GetClientTeam(client)==CS_TEAM_T || GetClientTeam(client)==CS_TEAM_CT)
		{
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
			SDKHook(client, SDKHook_TraceAttack, TraceAttack);
			SetEntProp(client, Prop_Data, "m_iFOV", 0);
			Client_RemoveAllWeapons(client,"weapon_knife",true);
			GivePlayerItem(client, "weapon_decoy");
			SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		}
	}	else
	if(startAbdul==1 && koniecAbdul==0 && numerZabawy==8)
	{
		SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		SDKHook(client, SDKHook_TraceAttack, TraceAttack);
	}
	
	if(startZeus==1 && koniecZeus==0 && numerZabawy==9)
	{
		SetEntProp(client,Prop_Send,"m_iHideHUD",GetEntProp(client,Prop_Send,"m_iHideHUD")^1<<12);
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		SDKHook(client, SDKHook_TraceAttack, TraceAttack);
		SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
	}
}

stock bool:IsValidPlayer(const any:client)
{
	return (0 < client <= MaxClients && IsClientInGame(client));
}