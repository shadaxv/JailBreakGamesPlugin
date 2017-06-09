#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <warden>
#include <cstrike>
#include <smlib>

bool wlaczona=false;
new licznik=0;
new numerZabawy=0;
bool byla[10]={false,false,false,false,false,false,false,false,false,false};
bool minuta=false;
new Handle:handleminuta=INVALID_HANDLE;
new Handle:handlezab1=INVALID_HANDLE;
new Handle:handlezab2=INVALID_HANDLE;
new Handle:handlezab3=INVALID_HANDLE;
new Float:odliczanie=5.0;
bool debugZabaw=false;
new uid=0;
new timerr=0;
new chowanyStart=0;
new g_WeaponParent;
new zeusammo[MAXPLAYERS+1] = {0, ...};
new g_hActiveWeapon = -1;
new g_iClip1 = -1;

char kolor0[32];
char kolor1[32];
char kolor22[32];
char kolor3[32];
char kolor4[32];
char przecinek[8] = "\x01, "
char kropka[8] = "."
char gang0[8];
char gang1[8];
char gang2[8];
char gang3[8];
char gang4[8];

#include "jailbreak_zabawy/jailbreak_polowanie.sp"
#include "jailbreak_zabawy/jailbreak_killday.sp"
#include "jailbreak_zabawy/jailbreak_ganiany.sp"
#include "jailbreak_zabawy/jailbreak_chowany.sp"
#include "jailbreak_zabawy/jailbreak_wojnygangow.sp"
#include "jailbreak_zabawy/jailbreak_zbijak.sp"
#include "jailbreak_zabawy/jailbreak_zeuswar.sp"
#include "jailbreak_zabawy/jailbreak_abdul.sp"
#include "jailbreak_zabawy/jailbreak_funkcje.sp"

public Plugin:myinfo = 
{
	name = "Zabawy JailBreak",
	author = "Aleksander Niedźwiedź",
	description = "Drużynowe zabawy JailBreak w CS:GO",
	version = "1.0",
	url = "https://github.com/shadaxv"
}
public OnPluginStart()
{
	RegConsoleCmd("sm_zabawa",PokazMenu);
	RegConsoleCmd("sm_reguly",PokazReguly);
	RegConsoleCmd("sm_kolor",WGKolor);
	RegAdminCmd("sm_anuluj",AnulujZabawe,ADMFLAG_CUSTOM1);
	RegConsoleCmd("sm_dxmdebug",DebugujPluginy);
	RegConsoleCmd("sm_resetzabaw",Resetuj);
	RegConsoleCmd("sm_logi",Logi);
	HookEvent("player_spawn", Event_PlayerSpawn);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
	HookEvent("player_death", KillZeus, EventHookMode_Pre);
	HookEvent("player_death", KillAbdul, EventHookMode_Pre);
	HookEvent("decoy_started", Event_DecoyStarted, EventHookMode_Pre);
	HookEvent("round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
	HookEvent("round_freeze_end", Event_RoundFreezeEnd,EventHookMode_PostNoCopy);
	AddCommandListener(Command_Drop, "drop");
	g_WeaponParent = FindSendPropOffs("CBaseCombatWeapon", "m_hOwnerEntity");
	g_hActiveWeapon = FindSendPropOffs("CCSPlayer", "m_hActiveWeapon");
	g_iClip1 = FindSendPropOffs("CBaseCombatWeapon", "m_iClip1");
}

public OnClientPutInServer(int client) 
{ 
	SDKHook(client, SDKHook_WeaponEquip, OnWeaponEquip);
	SDKHook(client, SDKHook_WeaponDrop, OnWeaponDrop);
}

public Action:DebugujPluginy(client,args)
{
	decl String:steamid[32];
	GetClientAuthId(client,AuthId_Steam2,steamid,sizeof(steamid));
	if(strcmp(steamid,"STEAM_1:1:24982202",true)==0 || strcmp(steamid,"STEAM_1:1:31060118",true)==0)
	{
		uid=GetClientUserId(client);
		debugZabaw=!debugZabaw;
		PrintToChat(client," \x0ESprawdz konsole, nowe dane debugu.");
		PrintToConsole(client,"\n**** Zabawy 1.5.1 ****\nDebug zostal %s.\n**********************\n",debugZabaw ? "wlaczony" : "wylaczony");
	} else PrintToChat(client,"[\x0BZabawy\x01] Wybacz, tylko gracz\x0E Dextromethorphanum\x01 moze tego uzyc.");
}

public Action:Logi(client,args)
{
	decl String:steamid[32];
	GetClientAuthId(client,AuthId_Steam2,steamid,sizeof(steamid));
	if(strcmp(steamid,"STEAM_1:1:31060118",true)==0)
	{
		new gang[5];
		new iloscZywych=0;
		for(new i=1; i<=GetMaxClients(); i++)
		{
			if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
			{
				gang[user_gangi[i]]++;
				iloscZywych++;
			}
		}
		uid=GetClientUserId(client);
		PrintToChat(client," \x0EWczytano dane, sprawdz konsole.");
		PrintToConsole(client,"\n**** LOGI ZABAW ****\n Polowanie: %d \n KillDay: %d \n Ganiany: %d \n Chowany: %d \n Wojny Gangow: %d \n Zbijak: %d \n Abdul Terrorysta: %d \n Zeus War: %d \n Licznik: %d \n Pierwsza minuta: %d \n ************** \n", byla[1]?1:0, byla[2]?1:0, byla[3]?1:0, byla[4]?1:0, byla[5]?1:0, byla[6]?1:0, byla[8]?1:0, byla[9]?1:0, licznik, minuta);
		PrintToConsole(client, "Liczba druzyn WG: %d \n Liczba TT na WG: %d \n Na starcie: Czerwony: %d, Zielony: %d, Niebieski: %d, Zolty: %d, Fioletowy: %d \n Teraz: Czerwony: %d, Zielony: %d, Niebieski: %d, Zolty: %d, Fioletowy: %d \n", zliczaj, iCountwg,licznikGangow[0],licznikGangow[1],licznikGangow[2],licznikGangow[3],licznikGangow[4],gang[0],gang[1],gang[2],gang[3],gang[4]);
	} else PrintToChat(client,"[\x0BZabawy\x01] Wybacz, tylko gracz\x0E Shadax\x01 moze tego uzyc.");
}

public Action:Resetuj(client,args)
{
	if (args < 1) {   
		ReplyToCommand(client, "[SM] Uzycie: sm_resetzabaw 0|1");
		return Plugin_Handled;
	}   
	
	decl String:steamid[32];
	GetClientAuthId(client,AuthId_Steam2,steamid,sizeof(steamid));
	if(strcmp(steamid,"STEAM_1:1:31060118",true)==0)
	{
		
		char arg[128];
		GetCmdArg(1, arg, sizeof(arg));
		
		if(strcmp(arg, "0", true)==0)
		{
			PrintToChat(client,"\x0EResetowanie zabaw!");
			PrintToChat(client, "Reset: 0");
			
			UsunZabawe();
			minuta=false;
			debugZabaw=false;
			chowanyStart = 0;
			
			koniecAbdul = 0;
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
			
			PrintToChat(client, "Polowanie: %d", byla[1]?1:0);
			PrintToChat(client, "KillDay: %d", byla[2]?1:0);
			PrintToChat(client, "Ganiany: %d", byla[3]?1:0);
			PrintToChat(client, "Chowany: %d", byla[4]?1:0);
			PrintToChat(client, "Wojny Gangow: %d", byla[5]?1:0);
			PrintToChat(client, "Zbijak: %d", byla[6]?1:0);
			PrintToChat(client, "Abdul Terrorysta: %d", byla[8]?1:0);
			PrintToChat(client, "Zeus War: %d", byla[9]?1:0);
			PrintToChat(client, "Licznik: %d", licznik);
			PrintToChat(client, "Pierwsza minuta: %d", minuta);
			
			return Plugin_Handled;
		}
		else if(strcmp(arg, "1", true)==0)
		{
			PrintToChat(client,"\x0EResetowanie zabaw!");
			PrintToChat(client, "Reset: 1");
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
			UsunZabawe();
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
			
			PrintToChat(client, "Polowanie: %d", byla[1]?1:0);
			PrintToChat(client, "KillDay: %d", byla[2]?1:0);
			PrintToChat(client, "Ganiany: %d", byla[3]?1:0);
			PrintToChat(client, "Chowany: %d", byla[4]?1:0);
			PrintToChat(client, "Wojny Gangow: %d", byla[5]?1:0);
			PrintToChat(client, "Zbijak: %d", byla[6]?1:0);
			PrintToChat(client, "Abdul Terrorysta: %d", byla[8]?1:0);
			PrintToChat(client, "Zeus War: %d", byla[9]?1:0);
			PrintToChat(client, "Licznik: %d", licznik);
			PrintToChat(client, "Pierwsza minuta: %d", minuta);
			
			return Plugin_Handled;
		}
		else ReplyToCommand(client, "[SM] Uzycie: sm_resetzabaw 0|1");
		
	} else PrintToChat(client,"[\x0BZabawy\x01] Wybacz, tylko gracz\x0E Shadax\x01 moze tego uzyc.");
	
	return Plugin_Handled;
}

public Action:PokazMenu(client,args)
{
	if(warden_iswarden(client))
	{
		MenuZabaw(client)
	} else PrintToChat(client,"\x01[\x04JailBreak\x01] Tylko Prowadzacy Straznik (\x04Warden\x01) moze wlaczyc zabawe!");
}
public Action:MenuZabaw(client)
{
	decl String:zabawa1[32];decl String:zabawa2[32];decl String:zabawa3[32];decl String:zabawa4[32];decl String:zabawa5[32];decl String:zabawa6[32];decl String:zabawa8[32];decl String:zabawa9[32];
	Format(zabawa1, sizeof(zabawa1), "Polowanie [%d/1]",byla[1]?1:0);
	Format(zabawa2, sizeof(zabawa2), "KillDay [%d/1]",byla[2]?1:0);
	Format(zabawa3, sizeof(zabawa3), "Ganiany [%d/1]",byla[3]?1:0);
	Format(zabawa4, sizeof(zabawa4), "Chowany [%d/1]",byla[4]?1:0);
	Format(zabawa5, sizeof(zabawa5), "Wojny Gangow [%d/1]",byla[5]?1:0);
	Format(zabawa6, sizeof(zabawa6), "Zbijak [%d/1]",byla[6]?1:0);
	Format(zabawa8, sizeof(zabawa8), "Abdul Terrorysta [%d/1]",byla[8]?1:0);
	Format(zabawa9, sizeof(zabawa9), "Zeus War [%d/1]",byla[9]?1:0);
	new Handle:menuzabaw = CreateMenu(MenuHandler1, MENU_ACTIONS_ALL);
	SetMenuTitle(menuzabaw, "Wybierz zabawe: [%d/3]",licznik);
	AddMenuItem(menuzabaw, "#choice1", zabawa1);
	AddMenuItem(menuzabaw, "#choice2", zabawa2);
	AddMenuItem(menuzabaw, "#choice3", zabawa3);
	AddMenuItem(menuzabaw, "#choice4", zabawa4);
	AddMenuItem(menuzabaw, "#choice5", zabawa5);
	AddMenuItem(menuzabaw, "#choice7", "Anuluj zabawe (tylko podczas odliczania)");
	AddMenuItem(menuzabaw, "#choice6", zabawa6);
	AddMenuItem(menuzabaw, "#choice8", zabawa8);
	AddMenuItem(menuzabaw, "#choice9", zabawa9);
	AddMenuItem(menuzabaw, "#choice7", "Anuluj zabawe (tylko podczas odliczania)");
	SetMenuPagination(menuzabaw, 7);
	SetMenuExitButton(menuzabaw, true);
	DisplayMenu(menuzabaw, client, 15);
	return Plugin_Handled;
}
public MenuHandler1(Handle:menuzabaw, MenuAction:action, param1, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			decl String:info[32];
			GetMenuItem(menuzabaw, param2, info, sizeof(info));
			if (StrEqual(info,"#choice1"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[1]==false)
							{
								StartPolowania(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=1;
								byla[1]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			} else if(StrEqual(info,"#choice2"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[2]==false)
							{
								StartKilldaya(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=2;
								byla[2]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			} else if(StrEqual(info,"#choice3"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[3]==false)
							{
								StartGanianego(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=3;
								byla[3]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			} else if(StrEqual(info,"#choice4"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[4]==false)
							{
								StartChowanego(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=4;
								byla[4]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			} else if(StrEqual(info,"#choice5"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[5]==false)
							{
								StartWojenGangow(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=5;
								byla[5]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			} else if(StrEqual(info,"#choice6"))
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[6]==false)
							{
								StartZbijaka(param1)
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=6;
								byla[6]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			}  else if(StrEqual(info,"#choice8")) //ABDUL
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[8]==false)
							{
								if(GetTeamClientCount(2) > 1)
								{
									AbdulStart(param1);
									FakeClientCommand(param1,"say !open");
									wlaczona=true;
									licznik++
									numerZabawy=8;
									byla[8]=true;
								}
								else
								{
									PrintToChat(param1, "\x01[\x04JailBreak\x01] Za malo osob do rozpoczecia zabawy");
								}
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			}  else if(StrEqual(info,"#choice9")) //ABDUL
			{
				if(minuta==false)
				{
					if(wlaczona==false)
					{
						if(licznik<3)
						{
							if(byla[9]==false)
							{
								ZeusStart(param1);
								FakeClientCommand(param1,"say !open");
								wlaczona=true;
								licznik++
								numerZabawy=9;
								byla[9]=true;
							} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Kazda zabawe mozna wlaczyc tylko\x04 raz\x01 w ciagu jednej mapy!");
						} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Mozna wlaczyc maksymalnie\x04 trzy\x01 zabawy w ciagu mapy!");
					} else PrintToChat(param1,"\x01[\x04JailBreak\x01] W ciagu jednej rundy mozna wlaczyc maksymalnie\x04 jedna\x01 zabawe!");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawe mozna wlaczyc tylko w ciagu \x04pierwszej minuty\x01 rundy!");
			}	else if(StrEqual(info,"#choice7"))
			{
				if(handlepol1!=INVALID_HANDLE || handlekd2!=INVALID_HANDLE || handlegn1!=INVALID_HANDLE || handlech1!=INVALID_HANDLE || handlewg2!=INVALID_HANDLE || handlez1!=INVALID_HANDLE || handleabdul!=INVALID_HANDLE || handlezeus!=INVALID_HANDLE)
				{
					byla[numerZabawy]=false;
					licznik--;
					for(new i=1;i<GetMaxClients();i++)
					{
						if(IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i)==CS_TEAM_T)
						{
							Client_RemoveAllWeapons(i,"weapon_knife",true);
							SetEntProp(i, Prop_Data, "m_iFOV", 0);
						}
					}
					UsunZabawe();
					LogAction(param1,-1,"WARDEN \"%L\" anulowal zabawe.",param1);
					PrintHintTextToAll("<font color='#FF0000'>Warden zadecydowal o anulowaniu zabawy!</font>\nWylaczono wszystkie funkcje zabaw.</font>");
				} else PrintToChat(param1,"\x01[\x04JailBreak\x01] Zabawa nie jest wlaczona, lub nie jest juz w fazie odliczania. Nie mozesz jej anulowac.");	
			}
		}
		case MenuAction_End:
		{
			CloseHandle(menuzabaw);
		} 
	}
	return 0;
}