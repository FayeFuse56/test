local GG=GG; if not GG then return game:GetService("Players").LocalPlayer:Kick("[TTJY Studio] : Really? Your account is now at risk for the next ban wave."); end;

local QUEUE_INFO = GG.QUEUE_INFO or {};
local ScriptCache = GG.ScriptCache;
local LoaderSettings = GG.LoaderSettings;
local userIdentify = ScriptCache.userIdentify;
local LowerC = hookfunction or hookfunc;
local GetService = game.GetService;
local Instancen = Instance.new;
local Vec3 = Vector3.new;
local str = string;
local tble = table;
local Col3 = Color3;
local tk = task;

local TextChatService = GetService(game, "TextChatService");
local TeleportService = GetService(game, "TeleportService");
local VIM = GetService(game, "VirtualInputManager");
local R = GetService(game, "ReplicatedStorage");
local H = GetService(game, "RunService");
local W = GetService(game, "Workspace");
local P = GetService(game, "Players");
local S = GetService(game, "Stats");

local IsA = game.IsA;
local twait = tk.wait;
local CFr = CFrame.new;
local Vec3 = Vector3.new;
local PivotTo = W.PivotTo;
local mfloor = math.floor;
local tblef = tble.find;
local strfind = str.find;
local tblein = tble.insert;
local GetPivot = W.GetPivot;
local GetChildren = game.GetChildren;
local GetAttribute = game.GetAttribute;
local WaitForChild = game.WaitForChild;
local GetDescendants = game.GetDescendants;
local FindFirstChild = game.FindFirstChild;
local PropChangeSignal = game.GetPropertyChangedSignal;
local FindFirstChildOfClass = game.FindFirstChildOfClass;
local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA;
local GetAttributeChangedSignal = game.GetAttributeChangedSignal;

local VEC3 = Vec3(3,3,3);
local VEC2 = Vec3(2,2,2);
local VEC252 = Vec3(2,5,2);
local VEC10 = Vec3(10, 10, 10);
local CFR9E9 = CFr(0, 9e9, 0);
local RED = Col3.fromRGB(255, 0, 0);
local BLUE = Col3.fromRGB(0, 0, 255);
local GREEN = Col3.fromRGB(0, 255, 0);
local YELLOW = Col3.fromRGB(255, 255, 0);
local WHITE = Col3.fromRGB(255, 255, 255);
local PURPLE = Col3.fromRGB(77, 23, 129);
local DIM0010 = UDim2.new(0,0,1,0);
local EMPTY_OBJECT = {Parent=nil, SeatPart=nil};
local PERSISTENT = Enum.ModelStreamingMode.Persistent;

local HUGE99 = 9e9;

local PlaceId = game.PlaceId;

local ScriptData = {
    Sections = {
        B1C1 = {
            [1] = (PlaceId == 6296321810 or PlaceId == 6479231833) and { i = "Map1", dat = {
                [1] = { i = "Spawn", C = CFr(269.3022155761719, 3, -1.3705496788024902) };
                [2] = { i = "Jigoku", C = CFr(316.1304626464844, 3.2333202362060547, 316.0523681640625) };
                [3] = { i = "Key 1", C = CFr(670.4268798828125, 3.049999713897705, 484.9584655761719) };
                [4] = { i = "Key 2", C = CFr(860.452880859375, 3.1949996948242188, 219.03762817382812) };
                [5] = { i = "Entrance Maze", C = CFr(3164.7529296875, 37.40338134765625, -1586.5648193359375) };
                [6] = { i = "Key 3", C = CFr(3317.523681640625, 37.64610290527344, -1764.0106201171875) };
                [7] = { i = "Exit Maze", C = CFr(3416.580322265625, 37.646121978759766, -1538.938720703125) };
            }} or {};
            [2] = (PlaceId == 6301638949 or PlaceId == 6480994221) and { i = "Map2", dat = {
                [1] = { i = "Spawn", C = CFr(284.4999084472656, 73.06249237060547, 101.47504425048828) };
                [2] = { i = "Cave House", C = CFr(32.434173583984375, 94.35484313964844, -1233.511962890625) };
                [3] = { i = "Entrance Main House", C = CFr(-112.36238861083984, 91.99998474121094, -2021.73974609375) };
                [4] = { i = "Spawn Hotel", C = CFr(-268.7034606933594, 91.63571166992188, -3243.083251953125) };
                [5] = { i = "Spawn Hotel 2nd Floor", C = CFr(-248.93421936035156, 128.62155151367188, -2547.898193359375) };
                [6] = { i = "Spawn Hotel 3rd Floor", C = CFr(237.497314453125, 199.52268981933594, -2568.7646484375) };
                [7] = { i = "Exit Hotel", C = CFr(1274.949951171875, 199.5399932861328, -2537.929931640625) };
                [8] = { i = "Spawn Outside Hotel", C = CFr(2139.439453125, 257.1267395019531, -2504.615966796875) };
                [9] = { i = "Chapter 2 Entrance Gate", C = CFr(2138.8232421875, 257.12353515625, -2742.88427734375) };
            }} or {};
        };
        B1C2 = {
            [1] = { i = "Map1", dat = {
                [1] = { i = "Spawn", C = CFr(31.30192756652832, 14.765870094299316, -50.99848937988281) };
                [2] = { i = "Key 1", C = CFr(146.7581329345703, 26.52265739440918, -429.7537841796875) };
                [3] = { i = "Lever Room", C = CFr(136.9575653076172, 14.773530006408691, -340.3115234375) };
                [4] = { i = "Exit Hallway", C = CFr(196.88290405273438, 26.39544677734375, -703.8648071289062) };
                [5] = { i = "Exit Samurai", C = CFr(234.37767028808594, 51.09593200683594, -1297.229736328125) };
                [6] = { i = "Butterfly 1", C = CFr(234.37767028808594, 51.09593200683594, -1297.229736328125) };
                [7] = { i = "Butterfly 2", C = CFr(220.61093139648438, 52.18296813964844, -1644.1612548828125) };
            }};
            [2] = { i = "Map2", dat = {
                [1] = { i = "Spawn", C = CFr(400.1822814941406, -47.07728958129883, 909.1865234375) };
                [2] = { i = "Butterfly Outside", C = CFr(431.97601318359375, 60.81093215942383, 380.8719787597656) };
                [3] = { i = "Key", C = CFr(161.5194091796875, 101.88359069824219, -562.4013671875) };
                [4] = { i = "Butterfly Inside", C = CFr(258.27105712890625, 94.61199188232422, -848.0752563476562) };
                [5] = { i = "Exit Door", C = CFr(235.35060119628906, 101.9432373046875, -551.535888671875) };
            }};
            [3] = { i = "Map3", dat = {
                [1] = { i = "Spawn", C = CFr(-96.32198333740234, 75.3413314819336, -22.335594177246094) };
                [2] = { i = "Butterfly", C = CFr(671.8909912109375, 78.17596435546875, -115.32154083251953) };
                [3] = { i = "Exit", C = CFr(827.9335327148438, 75.3413314819336, -352.0482482910156) };
            }};
        };
        B1C3 = {
            [1] = { i = "Map1", dat = {
                [1] = { i = "Spawn", C = CFr(1112.6671142578125, 83.19374084472656, -359.1717834472656) };
                [2] = { i = "Cave Spawn", C = CFr(1899.2449951171875, 4.8473639488220215, 281.3607177734375) };
                [3] = { i = "Kaito Entrance", C = CFr(2047.682861328125, -0.4862976670265198, 561.9852294921875) };
                [4] = { i = "Kaito Exit", C = CFr(2314.2900390625, 5.150242328643799, 818.3004760742188) };
                [5] = { i = "Hand Entrance", C = CFr(2408.81396484375, -23.031116485595703, 1459.683837890625) };
                [6] = { i = "Hand Exit", C = CFr(2413.467529296875, -23.03111457824707, 1816.749267578125) };
            }};
            [2] = { i = "Map2", dat = {
                [1] = { i = "Spawn", C = CFr(39.31187057495117, 36.4764518737793, 84.27843475341797) };
                [2] = { i = "Blade", C = CFr(79.64765930175781, 36.359718322753906, 87.4922866821289) };
                [3] = { i = "Butterfly", C = CFr(128.96363830566406, 36.35921859741211, 98.9471435546875) };
                [4] = { i = "Rose", C = CFr(322.61297607421875, 37.51033401489258, 78.7746810913086) };
                [5] = { i = "Bell Safe Spot", C = CFr(210.59703063964844, 31.717370986938477, 407.951416015625) };
            }};
        };
    };
};
local Config = GG.Configs or {};

Config.Client = Config.Client or {};
Config.Client.Client = Config.Client.Client or {};
Config.Yen = Config.Yen or {};
Config.B1C4 = Config.B1C4 or {};
Config.B1C4.Map4 = Config.B1C4.Map4 or {};
Config.B2C1 = Config.B2C1 or {};
Config.B2C1.City = Config.B2C1.City or {};
Config.B2C1.City.ESP = Config.B2C1.City.ESP or {};
Config.B2C1.Rat = Config.B2C1.Rat or {};
Config.B2C1.Rat.ESP = Config.B2C1.Rat.ESP or {};
Config.B2C1.Village = Config.B2C1.Village or {};
Config.B2C1.Village.ESP = Config.B2C1.Village.ESP or {};
Config.B2C1.Ship = Config.B2C1.Ship or {};
Config.B2C1.Ship.ESP = Config.B2C1.Ship.ESP or {};
Config.B2C2 = Config.B2C2 or {};
Config.B2C2.Meat = Config.B2C2.Meat or {};
Config.B2C2.Meat.ESP = Config.B2C2.Meat.ESP or {};
Config.B2C2.Lever = Config.B2C2.Lever or {};
Config.B2C2.Lever.ESP = Config.B2C2.Lever.ESP or {};
Config.B2C2.Cook = Config.B2C2.Cook or {};
Config.B2C2.Kid = Config.B2C2.Kid or {};
Config.B2C2.Kid.ESP = Config.B2C2.Kid.ESP or {};
Config.B2C2.Nagisa = Config.B2C2.Nagisa or {};
Config.B2C3 = Config.B2C3 or {};
Config.B2C3.Maze = Config.B2C3.Maze or {};
Config.B2C3.Maze.ESP = Config.B2C3.Maze.ESP or {};
Config.B2C3.Larves = Config.B2C3.Larves or {};
Config.B2C3.Larves.ESP = Config.B2C3.Larves.ESP or {};
Config.B2C3.Boss = Config.B2C3.Boss or {};
Config.B2C4 = Config.B2C4 or {};
Config.B2C4.City = Config.B2C4.City or {};
Config.B2C4.City.ESP = Config.B2C4.City.ESP or {};
Config.B2C4.Mall = Config.B2C4.Mall or {};
Config.B2C4.Mall.ESP = Config.B2C4.Mall.ESP or {};
Config.B2C4.Draw = Config.B2C4.Draw or {};
Config.B2C4.Draw.ESP = Config.B2C4.Draw.ESP or {};
Config.B2C4.Enzukai = Config.B2C4.Enzukai or {};
Config.B2C4.Enzukai.ESP = Config.B2C4.Enzukai.ESP or {};
Config.B2C4.Final = Config.B2C4.Final or {};
Config.B3C1 = Config.B3C1 or {};
Config.B3C1.City = Config.B3C1.City or {};
Config.B3C1.City.ESP = Config.B3C1.City.ESP or {};
Config.B3C1.School = Config.B3C1.School or {};
Config.B3C1.School.ESP = Config.B3C1.School.ESP or {};
Config.B3C1.Forest = Config.B3C1.Forest or {};
Config.B3C1.Forest.ESP = Config.B3C1.Forest.ESP or {};
Config.B3C1.IJO = Config.B3C1.IJO or {};
Config.B3C1.IJO.ESP = Config.B3C1.IJO.ESP or {};
Config.B3C1.Water = Config.B3C1.Water or {};
Config.B3C1.Water.ESP = Config.B3C1.Water.ESP or {};
Config.NMCS = Config.NMCS or {};
Config.Jigoku = Config.Jigoku or {};
Config.Jigoku.ESP = Config.Jigoku.ESP or {};
Config.Egao = Config.Egao or {};
Config.WitchTrial = Config.WitchTrial or {};
Config.WitchTrial.ESP = Config.WitchTrial.ESP or {};
Config.HalloweenTrial = Config.HalloweenTrial or {};
Config.HalloweenTrial.ESP = Config.HalloweenTrial.ESP or {};

return {
    Version = "TheMimicV3.D15";
    Function = function(CorePackage, WindLib, IntroLib, Windy, ClientPackage, CoruTask, CommonF, ESPF, PromptPackage, DownloadPackage, QueuePack)
        local CoreConnection    = {};
        local CoreDestroyed     = false;
        local ForceFloat        = "None";

        local CAMERAOBJECT      = EMPTY_OBJECT;
        local Cam               = W.CurrentCamera;
        local selff             = P.LocalPlayer;
        local PSG               = selff.PlayerGui;
        local BP                = selff.Backpack or EMPTY_OBJECT;
        local selc              = selff.Character or EMPTY_OBJECT;
        local HumSelf           = selc.Parent and FindFirstChildOfClass(selc, "Humanoid") or EMPTY_OBJECT;
        local HumRSelf          = HumSelf.RootPart or EMPTY_OBJECT;
        local PSS               = WaitForChild(selff, "PlayerScripts", HUGE99);

        local VOIDPART          = Instancen("Part");

        local cmdm              = selff:GetMouse();
        local ClientCon         = Config.Client.Client;
        local YenCon            = Config.Yen;
        local B1C4Con           = Config.B1C4;
        local B2C1Con           = Config.B2C1;
        local B2C2Con           = Config.B2C2;
        local B2C3Con           = Config.B2C3;
        local B2C4Con           = Config.B2C4;
        local B3C1Con           = Config.B3C1;
        local NMCSCon           = Config.NMCS;
        local NonAnalytics3     = {type="Button", EN="Analytics 3", EN2="Please enable 'Analytics 3' module to track game data, inventory, and player statistics for reports and webhook integrations.", TH1="Analytics 3", TH2="กรุณาเปิดใช้งานโมดูล 'Analytics 3' เพื่อติดตามข้อมูลเกม สินค้าคงคลัง และสถิติผู้เล่นสำหรับรายงานและเว็บฮุก"};
        local ArgsCraft         = {[1] = 0;[2] = {["__args"] = {};["__tree"] = {[1] = "CraftingService";[2] = "Interact"};["__callType"] = 0}};

        local Chapter           = if PlaceId == 6296321810 or PlaceId == 6479231833 or PlaceId == 6301638949 or PlaceId == 6480994221 then "B1C1"
                                  elseif PlaceId == 6373539583 or PlaceId == 6485055338 or PlaceId == 6406571212 or PlaceId == 6485055836 or PlaceId == 6425178683 or PlaceId == 6485056556 then "B1C2"
                                  elseif PlaceId == 6472459099 or PlaceId == 6688734180 or PlaceId == 6682163754 or PlaceId == 6688734313 or PlaceId == 6682164423 or PlaceId == 6688734395 then "B1C3"
                                  elseif PlaceId == 7251865082 or PlaceId == 7265396387 or PlaceId == 7251866503 or PlaceId == 7265396805 or PlaceId == 7251867155 or PlaceId == 7265397072 or PlaceId == 7251867574 or PlaceId == 7265397848 then "B1C4"
                                  elseif PlaceId == 8056702588 then "B2C1"
                                  elseif PlaceId == 13489800654 then "B2C2"
                                  elseif PlaceId == 15962819441 then "B2C3"
                                  elseif PlaceId == 96354063422506 then "B2C4"
                                  elseif PlaceId == 128715637193371 then "B3C1"
                                  elseif PlaceId == 7618863566 then "Jigoku"
                                  elseif PlaceId == 7068738088 or PlaceId == 7068951438 or PlaceId == 7068739000 or PlaceId == 7068951914 or PlaceId == 7068740106 or PlaceId == 7068952294 then "WitchTrial"
                                  elseif PlaceId == 7633631103 or PlaceId == 7633631351 or PlaceId == 7633631511 then "HalloweenTrial"
                                  elseif PlaceId == 11126398230 then "NMCS"
                                  elseif PlaceId == 16750505007 then "Ken"
                                  elseif PlaceId == 6243699076 then "Lobby"
                                  elseif PlaceId == 7068737459 then "GLobby"
                                  else nil;

        local GameAI, GameAI2   = nil, nil;

        local dist              = CommonF.dist;
        local Tp                = CommonF.Tp;
        local HumanoidEquip     = CommonF.HumanoidEquip;
        local Tween             = CommonF.Tween;
        local Anchored          = CommonF.Anchored;
        local distOf            = CommonF.distOf;

        local RE                = {};
        local REQ               = {};
        local Functions         = {};

        ClientCon.JumpPower = ClientCon.JumpPower or 50;
        ClientCon.SpeedMultiplier = ClientCon.SpeedMultiplier or 1;
        ClientCon["TeleportWalk Speed"] = ClientCon["TeleportWalk Speed"] or 1;

        Functions.SKey = function(VIM, key)
            return VIM:SendKeyEvent(true, key, false, W);
        end;
        Functions.OKey = function(VIM, key)
            return VIM:SendKeyEvent(false, key, false, W);
        end;
        Functions.CKey = function(self, VIM, key, c, c2)
            return self.SKey(VIM, key), twait(c or 0), self.OKey(VIM, key), twait(c2 or 0);
        end;
        Functions.PairingSections = function(self, data)
            if not self.PackSections and data[Chapter] then
                local PackSections = {Tabs={}};
                local GroupDat = {};

                for i=1, #data[Chapter] do
                    local sec=data[Chapter][i];
                    if not sec or not sec.dat then continue; end;
                    for i2=1, #sec.dat do
                        tblein(GroupDat, {
                            type = "Button";
                            EN = sec.dat[i2].i;
                            Callback = function()
                                Tp(HumRSelf, sec.dat[i2].C);
                            end;
                        });
                    end;
                end;
                
                PackSections.Tabs = {{
                    Tab={at="Section", Title="Sections", Icon="map-pinned", Path=Chapter}, Data=GroupDat
                }}; self.PackSections = PackSections;
            end;

            return LoaderSettings.TheMimicLoader.Load_Sections and self.PackSections or {};
        end;
        Functions.GetPing = function()
            return S.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000;
        end;
        Functions.GameValidate = function(self)
            if PlaceId == 6243699076 then
                WaitForChild(selc, "AntiFly", 9e9).Enabled = false;
            end; if Chapter == "B1C4" or Chapter == "WitchTrial" then
                WaitForChild(PSS, "Anti-Fly", 9e9).Enabled = false;
                WaitForChild(PSS, "Anti-Speed", 9e9).Enabled = false;
            end; if PlaceId == 7251867574 or PlaceId == 7265397848 then
                local Katana = FindFirstChild(BP, "Katana") or FindFirstChild(selc, "Katana");
                if not Katana then
                    Katana = WaitForChild(BP, "Katana", 9e9);
                end; self.Katana = Katana;
            end; if Chapter == "B2C3" then
                local GrabbedUI = FindFirstChild(PSG, "QuickTime");
                local BoneSword = FindFirstChild(BP, "Bone Sword") or FindFirstChild(selc, "Bone Sword");
                if not BoneSword then
                    tk.defer(function() self.BoneSword = WaitForChild(BP, "Bone Sword", 9e9); end);
                else self.BoneSword = BoneSword; end;
                self.GrabbedUI = FindFirstChild(GrabbedUI, "GrabbedUI");
            end; if Chapter == "B2C4" then
                local GrabbedUI = FindFirstChild(PSG, "QuickTime");
                local Bow = FindFirstChild(BP, "SpiritBow") or FindFirstChild(selc, "SpiritBow");
                if not Bow then
                    tk.defer(function() self.Bow = WaitForChild(BP, "SpiritBow", 9e9); end);
                else self.Bow = Bow; end;
                self.GrabbedUI = FindFirstChild(GrabbedUI, "GrabbedUI");
            end; if Chapter == "B3C1" then
                local Gun = FindFirstChild(BP, "Gun") or FindFirstChild(selc, "Gun");
                if not Gun then
                    tk.defer(function() self.Gun = WaitForChild(BP, "Gun", 9e9); end);
                else self.Gun = Gun; end;
            end; if self.AlreadyInit then return; end; self.AlreadyInit = true;
            if Chapter == "B2C1" or Chapter == "B2C2" then
                local DynamicControl, GCs = nil, getgc(true);
                repeat
                    for i=1, #GCs do
                        local v=GCs[i]; if type(v) == 'function' then
                            if debug.info(v, "n") == "DynamicControl" then
                                DynamicControl = v; break;
                            end;
                        elseif type(v) == 'table' then
                            if rawget(v, "TakeOver") then
                                self.TakeOver = v;
                            end;
                        end;
                    end; if not DynamicControl then
                        GCs = getgc(true); 
                    end; twait(2);
                until self.TakeOver and DynamicControl;
                    
                local UPs = getupvalues(DynamicControl); for i=1, #UPs do
                    local f1=UPs[i]; if type(f1) == 'function' then
                        local UPs2 = getupvalues(f1);
                        for i2=1, #UPs2 do
                            local v=UPs2[i2]; if type(v) == 'table' and (v.Interactable or v.Safe) then
                                self.u18 = v; break;
                            end;
                        end;
                    end;
                end;
            elseif Chapter == "B2C3" then
                local GamemodeMode = GetAttribute(W, "GamemodeMode");
                if not GamemodeMode then
                    GetAttributeChangedSignal(W, "GamemodeMode"):Once(function()
                        GamemodeMode = GetAttribute(W, "GamemodeMode");
                    end);
                end; self.GameMode = GamemodeMode;
                self.OneRunHouseClicked = {};
            elseif Chapter == "B2C4" then
                self.AnsweredMother = {
                    ["cult name?"] = "Kiiroibara Cult";
                    ["I bloom"] = "Cherry Blossom";
                    ["Four I shaped in shadows dire—"] = "Evil God";
                    ["pink"] = " Hiachi Masashige";
                    ["quietly"] = "Torii Gate";
                    ["pathetic"] = "Me";
                    ["in ink"] = "A brush";
                    ["Flames"] = "Enzukai";
                    ["guard"] = "A komainu";
                };

                tk.spawn(function()
                    local Section4 = WaitForChild(W, "Section4", 9e9);

                    tk.spawn(function()
                        self.Tsukiya2 = WaitForChild(WaitForChild(Section4, "Monster4", 9e9), "Tsukiya2", 9e9);
                    end); tk.spawn(function()
                        self.Tenome2 = WaitForChild(WaitForChild(Section4, "Monster3", 9e9), "Tenome2", 9e9);
                    end); tk.spawn(function()
                        self.Rin2 = WaitForChild(WaitForChild(Section4, "Monster2", 9e9), "Rin2", 9e9);
                    end);
                end);
            end;
        end;
        Functions.FreeCam = function(self, isFree)
            Cam = W.CurrentCamera;

            if self.TakeOver then
                self.TakeOver:TakeOver(not isFree);
            end;

            if Chapter == "B2C1" then
                if isFree then
                    Cam.CameraType = Enum.CameraType.Scriptable;
                end;
            end;
        end;
        Functions.FreeYourself = function(self)
            if not self.GrabbedUI or not self.GrabbedUI.Visible then
                return;
            end; CommonF:CKey(Enum.KeyCode.E, 0.03);
        end;
        Functions.FirePrompt = function(self, args)
            local Prompt = args.Prompt;
            local EndAt = args.EndAt;
            local LookAt = args.LookAt;

            if not Prompt then return; end;
            local Max = Prompt.MaxActivationDistance;
            Prompt.MaxActivationDistance = 250;
            Prompt.RequiresLineOfSight = false;
            
            self:FreeCam(true);
            Cam.CFrame = CFr(EndAt.Position, LookAt);
            Tp(HumRSelf, EndAt, 0.3);
            Prompt:InputHoldBegin();
            H.RenderStepped:Wait();

            Tp(HumRSelf, args.Safe);
            tk.delay(Prompt.HoldDuration - 0.2, function()
                Tp(HumRSelf, EndAt);
            end); twait(Prompt.HoldDuration);
            Prompt:InputHoldEnd(); twait(0.1)

            self:FreeCam(false);
            Prompt.MaxActivationDistance = Max;
        end;
        Functions.ToolNow = function(self, index)
            if not selc.Parent then return false; end;
            local Tool = self[index]; if Tool and Tool.Parent ~= selc then
                HumanoidEquip(HumSelf, Tool);
            elseif not Tool then
                return false;
            end; return Tool;
        end;
        Functions.ToolActive = function(self, index)
            local Tool = self:ToolNow(index); if Tool then
                return Tool:Activate();
            end; return;
        end;
        Functions.AutoCompleteBook1 = function()
            if PlaceId == 6296321810 or PlaceId == 6479231833 then
                return Tp(HumRSelf, CFr(3507, 37.65, -1539.45));
            elseif PlaceId == 6301638949 or PlaceId == 6480994221 then
                return Tp(HumRSelf, CFr(1274.95, 199.54, -2537.93));
            end;
            if PlaceId == 6373539583 or PlaceId == 6485055338 then
                return Tp(HumRSelf, CFr(64.88, 55.28, -1590));
            elseif PlaceId == 6406571212 or PlaceId == 6485055836 then
                return Tp(HumRSelf, CFr(235.17, 101.94, -590));
            elseif PlaceId == 6425178683 or PlaceId == 6485056556 then
                return Tp(HumRSelf, CFr(829.97, 72.49, -353.46));
            end;
            if PlaceId == 6472459099 or PlaceId == 6688734180 then
                return Tp(HumRSelf, CFr(2411.93, -23.03, 2300));
            elseif  PlaceId == 6682163754 or PlaceId == 6688734313 then
                return Tp(HumRSelf, CFr(245.69, 31.72, 450));
            elseif  PlaceId == 6682164423 or PlaceId == 6688734395 then
                return Tp(HumRSelf, CFr(-651, 648.99, -1014.35), 5), Tp(HumRSelf, CFr(-644.07, 947.82, -1490));
            end;
            if PlaceId == 7251865082 or PlaceId == 7265396387 then
                return Tp(HumRSelf, CFr(91, -48.35, -1416.24));
            elseif PlaceId == 7251866503 or PlaceId == 7265396805 then
                local CHs = GetChildren(W.Butterflies); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(v.ProximityPrompt, 1);
                    end;
                end;
            elseif PlaceId == 7251867155 or PlaceId == 7265397072 then
                local CHs = GetChildren(W.GameInfo.PuzzleItems); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.ProximityPrompt.Enabled then
                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(v.ProximityPrompt);
                    end;
                end; Tp(HumRSelf, CFr(688.41, 28.37, 2251.57), 0.3);
                local Burner = W.Well.Burner; for i=1, 6 do
                    fireproximityprompt(Burner.ProximityPrompt);
                end;
            end;
        end;
        Functions.ESPMonsterBook1 = function(state)
            if not state then return ESPF.Visible("Monster", false); else
                if GameAI then
                    local CHs = GetChildren(GameAI); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            ESPF.ESP("Monster", v, {
                                Color = RED;
                                Size = VEC10;
                                Text = v.Name;
                            });
                        end;
                    end;
                end; if GameAI2 then
                    local CHs = GetChildren(GameAI2); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            ESPF.ESP("Monster", v, {
                                Color = RED;
                                Size = VEC10;
                                Text = v.Name;
                            });
                        end;
                    end;
                end; if Chapter == "B1C3" then
                    local Omu = FindFirstChild(W, "omukadeMAIN");
                    local DMGP = Omu and FindFirstChild(Omu, "damagepart");
                    if DMGP then DMGP.Transparency = 0; end;
                    if Omu then ESPF.ESP("Monster", DMGP, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Train Chu Chu LOL";
                    }); end;
                end; ESPF.Visible("Monster", true,  true);
            end; return;
        end;
        Functions.ESPItemsBook1 = function(state)
            if not state then return ESPF.Visible("Items", false); else
                local Givers = FindFirstChild(W, "Givers");
                if Givers then
                    local CHs = GetChildren(Givers); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            ESPF.ESP("Items", v, {
                                Color = WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        end;
                    end;
                end; if Chapter == "B1C2" or PlaceId == 6682164423 or PlaceId == 6688734395 then
                    local CHs = GetChildren(W); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            if v.Name ~= "Key1" and v.Name ~= "Butterfly" and not FindFirstChild(v, "ProxPart") then continue; end;
                            ESPF.ESP("Items", v, {
                                Color = WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        end;
                    end;
                elseif PlaceId == 6472459099 or PlaceId == 6688734180 then
                    local CHs = GetChildren(W); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            if v.Name ~= "Butterfly" and v.Name ~= "Crowbar" and v.Name ~= "Blade" then continue; end;
                            ESPF.ESP("Items", v, {
                                Color = WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        end;
                    end; ESPF.ESP("Items", FindFirstChild(W.OfferItem, "Sword"), {
                        Color = GREEN;
                        Size = VEC2;
                        Text = "Place sword here";
                    });
                elseif PlaceId == 6682163754 or PlaceId == 6688734313 then
                    local CHs = GetChildren(W.BellFolder); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Prox = FindFirstChild(v, "ProximityPrompt");
                            if not Prox then continue; end;
                            local ESPObject = ESPF.ESP("Items", v, {
                                Color = if Prox.Enabled then YELLOW else GREEN;
                                Size = VEC2;
                                Text = v.Name;
                            }); PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(GREEN);
                            end);
                        end;
                    end;
                elseif PlaceId == 7251865082 or PlaceId == 7265396387 then
                    local CHs = GetChildren(W); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Prox = FindFirstChild(v, "ProxPart");
                            if Prox then 
                                ESPF.ESP("Items", Prox, {
                                    Color = WHITE;
                                    Size = VEC2;
                                    Text = Prox.ProximityPrompt.ObjectText;
                                });
                            elseif FindFirstChild(v, "Model") and FindFirstChild(v.Model, "Model") then
                                local Prox = FindFirstChild(v.Model.Model, "ProxPart", true);
                                if not Prox then continue; end;
                                ESPF.ESP("Items", Prox, {
                                    Color = WHITE;
                                    Size = VEC2;
                                    Text = Prox.ProximityPrompt.ObjectText;
                                });
                            end;
                        end;
                    end;
                elseif PlaceId == 7251866503 or PlaceId == 7265396805 then
                    local CHs = GetChildren(W.Butterflies); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local ESPObject = ESPF.ESP("Items", v, {
                                Color = WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        end;
                    end;
                elseif PlaceId == 7251867155 or PlaceId == 7265397072 then
                    local CHs, CHs2 = GetChildren(W), GetChildren(W.GameInfo.PuzzleItems);
                    for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            if v.Name == "Model" and FindFirstChild(v, "Spirit") then
                                ESPF.ESP("Items", v.Spirit.ProxPart, {
                                    Color = WHITE;
                                    Size = VEC2;
                                    Text = "Butterfly";
                                });
                            elseif v.Name == "Key" then
                                ESPF.ESP("Items", v, {
                                    Color = WHITE;
                                    Size = VEC2;
                                    Text = v.Name;
                                });
                            end;
                        end;
                    end; for i=1, #CHs2 do
                        local v=CHs2[i]; if v.Parent then
                            local Prox = FindFirstChild(v, "ProximityPrompt");
                            local ESPObject = ESPF.ESP("Items", v, {
                                Color = if Prox.Enabled then YELLOW else GREEN;
                                Size = VEC2;
                                Text = "Cursed Item";
                            }); PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(if Prox.Enabled then YELLOW else GREEN);
                            end);
                        end;
                    end;
                elseif PlaceId == 7251867574 or PlaceId == 7265397848 then
                    local CHs = GetChildren(W.GameHearts); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local HPs = FindFirstChild(v, "Health");
                            if not HPs then continue; end;
                            local ESPObject = ESPF.ESP("Items", v, {
                                Color = if HPs.Value > 0 then YELLOW else GREEN;
                                Size = VEC2;
                                Text = v.Name;
                            }); PropChangeSignal(HPs, "Value"):Connect(function()
                                ESPObject.UpdateColor(if HPs.Value > 0 then YELLOW else GREEN);
                            end);
                        end;
                    end;
                end;
            end; ESPF.Visible("Items", true, true);
        end;
        Functions.B2C1Validate = function(self, obj, from)
            if self[obj] then return true; end;
            local Connections = getconnections(obj[from]); for i=1, #Connections do
                local vf=Connections[i]; if type(vf.Function) == 'function' then
                    local Cons = getconstants(vf.Function); for ri=1, #Cons do
                        local Con=Cons[ri]; if type(Con) == 'string' then
                            local Lowerest = str.lower(Con);
                            if Lowerest == 'billboardgui' or Lowerest == 'highlight' then
                                debug.setconstant(vf.Function, ri, "TJYS");
                            end;
                        end;
                    end;
                end;
            end; self[obj]=true;
            return self[obj];
        end;
        Functions.B2C1Get = function(self, obj)
            local B2C1Cache = self.B2C1Cache;
            if not B2C1Cache then
                B2C1Cache = {};
                self.B2C1Cache = B2C1Cache;
            end; if not B2C1Cache[obj] then
                local parts = str.split(obj, ".");
                local resolvedParts = {};
                local skipNext = false;
                for i = 1, #parts do
                    if skipNext then
                        skipNext = false;
                    else
                        local part = parts[i];
                        if i < #parts and tonumber(parts[i+1]) and not tonumber(part) then
                            part = part .. "." .. parts[i+1];
                            skipNext = true;
                        end;
                        tblein(resolvedParts, part);
                    end;
                end;
                parts = resolvedParts;

                local current = game;
                local startIdx = 1;
                if parts[1] == "Workspace" or parts[1] == "workspace" then
                    current = W;
                    startIdx = 2;
                end;
                for i = startIdx, #parts do
                    local name = parts[i];
                    local scrambled = self.u18 and self.u18[name] or name;
                    current = current and FindFirstChild(current, scrambled);
                    if not current then break; end;
                end; B2C1Cache[obj] = current;
            end; return B2C1Cache[obj];
        end;
        Functions.B2C1Func = function(self, where)
            if not HumRSelf.Parent then return; end;
            if where == "City/Complete" then
                return Tp(HumRSelf, CFr(-1783, 11, -4297));
            elseif where == "Rat/Book" then
                local Object = self:B2C1Get("Workspace.Section2.BookRead.Book");
                if not Object then return; end; local Interact = FindFirstChild(Object, "Interact");
                local Prox = Interact and FindFirstChildOfClass(Interact, "ProximityPrompt");
                if not Prox or not Prox.Enabled then return; end;
                return Tp(HumRSelf, Interact.CFrame, 0.3), fireproximityprompt(Prox);
            elseif where == "Rat/Rat" then
                local Object = self:B2C1Get("Workspace.Section2.Rats");
                local Well = self:B2C1Get("Workspace.Section2.Interactable.PoisonedWell.ProximityPrompt");
                local Bell = self:B2C1Get("Workspace.Section2.Interactable.Bell.ProximityPrompt");
                if not Object or not Well or not Bell then return; end;
                local CHs = GetChildren(Object); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "Cube");
                        Prox = Prox and FindFirstChildOfClass(Prox, "ProximityPrompt");
                        if not Prox then continue; end;
                        Tp(HumRSelf, Prox.Parent.CFrame, 0.3)
                        fireproximityprompt(Prox);
                        Tp(HumRSelf, Well.Parent.CFrame, 0.3);
                        fireproximityprompt(Well); twait(5);
                        Tp(HumRSelf, Bell.Parent.CFrame, 0.3);
                        fireproximityprompt(Bell); break;
                    end;
                end;
            elseif where == "Rat/Exit" then
                local Object = self:B2C1Get("Workspace.Section2.Interactable.Exit.ProximityPrompt");
                if not Object or not Object.Enabled then return; end;
                Tp(HumRSelf, Object.Parent.CFrame, 0.3); fireproximityprompt(Object);
            elseif where == "Rat/Run" then
                Tween({primary = HumRSelf; goal = { CFrame = CFr(-960.842529, -44.0736237, -3597.06372) }});
            elseif where == "Nagisa/Auto" then
                ForceFloat = true; CommonF.Tween({ primary = HumRSelf; goal = { CFrame = CFr(208.665894, 573.239563, -345.685211) } });
                twait(3); CommonF.Tween({ primary = HumRSelf; goal = { CFrame = CFr(595.243896, 582.230713, -344.577911) } }); ForceFloat = "None";
            elseif where == "Nagisa/Run" then
                ForceFloat = true; CommonF.Tween({ primary = HumRSelf; goal = { CFrame = CFr(3868.31982, 153.007477, 17.1698914) } }); ForceFloat = "None";
            elseif where == "Vil/Zone" then
                Tween({primary = HumRSelf; goal = { CFrame = CFr(4590.5249, 507.557373, 4480.6499) }});
            elseif where == "Vil/Talk" then
                Tp(HumRSelf, CFr(-326.344421, 23.1051254, 3662.32056));
            elseif where == "Vil/Key" then
                Tp(HumRSelf, CFr(-401.797424, 3070.25, 3864.77979), 1);
                local Object = self:B2C1Get("Workspace.Section4");
                if not Object then return; end;
                local Items = FindFirstChild(Object, "Items");
                local Key = Items and FindFirstChild(Items, "Key1");
                local Prox = Key and FindFirstChildOfClass(Key, "ProximityPrompt");
                if not Prox then return; end;
                Tp(HumRSelf, Key.CFrame, 0.3); fireproximityprompt(Prox);
            elseif where == "Vil/PaintTp" then
                Tp(HumRSelf, CFr(-249.45462, 3067.58838, 4218.84766));
            elseif where == "Vil/Pics" then
                local Object = self:B2C1Get("Workspace.Section4.Puzzle.Hints");
                if not Object then return; end; local CHs = GetChildren(Object);
                
                if not self.Hints then
                    self.Hints = Object.ChildAdded:Connect(function(v)
                        if v.ClassName == "Model" then
                            v.ModelStreamingMode = PERSISTENT;
                        end;
                    end);

                    for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            v.ModelStreamingMode = PERSISTENT;
                        end;
                    end;

                    self.Cords = {
                        CFr(-267.697571, 3070.85718, 4213.41504),
                        CFr(590.236572, 3070.94922, 4420.93457),
                        CFr(-675.159424, 3071.0813, 4998.77686),
                        CFr(-392.277039, 3071.03931, 3888.39697),
                        CFr(-10.6637068, 3070.17041, 4711.52637),
                    };
                end;

                for i=1, #self.Cords do
                    local v=self.Cords[i];
                    Tp(HumRSelf, v, 2);
                end;
            elseif where == "Vil/House" then
                local Object = self:B2C1Get("Workspace.Section4.HouseTeleporters.MainHouse.Enter.Teleporter.ProximityPrompt");
                if not Object or not Object.Enabled then return; end;
                Tp(HumRSelf, Object.Parent.CFrame, 0.3); for i=1, 2 do
                    fireproximityprompt(Object); twait(0.3);
                end;
            elseif where == "Vil/Candle" then
                local Hints = self:B2C1Get("Workspace.Section4.Puzzle.Hints");
                local Images = self:B2C1Get("Workspace.Section4.Puzzle.Frames");
                local Candles = self:B2C1Get("Workspace.Section4.Puzzle.Candles");
                if not Hints or not Images or not Candles then return; end;
                local Orb = self:B2C1Get("Workspace.Section4.Puzzle.Gem.Seishin.Orb.ProximityPrompt");
                if not Orb then
                    local Pics4, Names = {}, {};
                    local CHs = GetChildren(Hints); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Image = FindFirstChild(v, "Image");
                            if not Image then continue; end;
                            tblein(Pics4, Image.Decal.Texture);
                        end;
                    end;

                    CHs = GetChildren(Images); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Image = FindFirstChild(v, "Image");
                            if not Image then continue; end;
                            if tblef(Pics4, Image.Decal.Texture) then
                                tblein(Names, v.Name);
                            end;
                        end;
                    end;

                    CHs = GetChildren(Candles); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            if tblef(Names, v.Name) then
                                local Candle = FindFirstChild(v, "Candle");
                                local Wax = Candle and FindFirstChild(Candle, "Wax");
                                local Prox = Wax and FindFirstChildOfClass(Wax, "ProximityPrompt");
                                if not Prox or not Prox.Enabled then continue; end;
                                Tp(HumRSelf, Wax.CFrame, 0.3); fireproximityprompt(Prox);
                            end;
                        end;
                    end; twait(1);
                end; Orb = self:B2C1Get("Workspace.Section4.Puzzle.Gem.Seishin.Orb.ProximityPrompt");
                if Orb and Orb.Enabled then
                    Tp(HumRSelf, Orb.Parent.CFrame, 0.3);
                    fireproximityprompt(Orb);
                end; self:B2C1Func("Vil/Talk");
            elseif where == "Ship/Enter" then
                Tp(HumRSelf, CFr(-1250, 4, 6299.65));
            elseif where == "Ship/Candle" then
                local Rituals = self:B2C1Get("Workspace.Section5.RitualLight");
                if not Rituals then return; end; local CHs = GetChildren(Rituals);
                
                if not self.Rituals then
                    self.Rituals = Rituals.ChildAdded:Connect(function(v)
                        if v.ClassName == "Model" then
                            v.ModelStreamingMode = PERSISTENT;
                        end;
                    end);

                    for i=1, #CHs do
                        local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                            v.ModelStreamingMode = PERSISTENT;
                        end;
                    end;

                    self.Cords = {
                        CFr(-6064, 547, 7146),
                        CFr(-6821, 759, 6431),
                        CFr(-5443, 461, 6336),
                    };

                    for i=1, #self.Cords do
                        local v=self.Cords[i];
                        Tp(HumRSelf, v, 0.3);
                    end; CHs=GetChildren(Rituals);
                end; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChildWhichIsA(v, "ProximityPrompt", true);
                        if not Prox or not Prox.Enabled then continue; end;
                        ForceFloat = true;
                        self:FirePrompt({
                            Safe = Prox.Parent.CFrame * CFr(0, -10, 0);
                            Prompt = Prox;
                            LookAt = Prox.Parent.Position;
                            EndAt = Prox.Parent.CFrame * CFr(0, 3, 0);
                        });
                    end; ForceFloat = "None";
                end;
            elseif where == "Ship/Run" then
                Tp(HumRSelf, CFr(-6318.51, 418.696014, 6332.39));
            end;
        end;
        Functions.B2C1ESP = function(self, where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "City/Key" then
                local Object = self:B2C1Get("Workspace.Section1.Items.Key");
                if not Object then return; end;
                ESPF.ESP(where, Object, {
                    Color = WHITE;
                    Size = VEC2;
                    Text = "Key";
                });
            elseif where == "Rat/Book" then
                local Object = self:B2C1Get("Workspace.Section2.BookRead.Book");
                if not Object then return; end; local ESPObject = ESPF.ESP(where, Object, {
                    Color = YELLOW;
                    Size = VEC2;
                    Text = "Book";
                }); local Interact = FindFirstChild(Object, "Interact"); if Interact then
                    Interact.Destroying:Connect(function()
                        ESPObject.UpdateColor(GREEN);
                    end);
                else
                    ESPObject.UpdateColor(GREEN);
                end;
            elseif where == "Rat/Futakuchi" then
                local Object = self:B2C1Get("Workspace.Section2.Monsters.Futakuchi");
                if not Object then return; end; if self:B2C1Validate(Object, "DescendantAdded") then
                    ESPF.ESP(where, Object, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Futakuchi";
                    });
                end;
            elseif where == "Rat/Rat" then
                local Object = self:B2C1Get("Workspace.Section2.Rats");
                if not Object then return; end;
                local CHs = GetChildren(Object); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "Cube");
                        Prox = Prox and FindFirstChildOfClass(Prox, "ProximityPrompt");
                        if not Prox then continue; end;
                        local ESPObject = ESPF.ESP(where, Prox.Parent, {
                            Color = if Prox.Enabled then YELLOW else GREEN;
                            Size = VEC2;
                            Text = "Rat";
                        }); if not ESPObjects[Prox] then
                            ESPObjects[Prox] = PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(if Prox.Enabled then YELLOW else GREEN);
                            end);
                        end;
                    end;
                end;
            elseif where == "Vil/Kurobozu" then
                local Object = self:B2C1Get("Workspace.Section4.Monsters.Kurobozu");
                if not Object then return; end; if self:B2C1Validate(Object, "DescendantAdded") then
                    ESPF.ESP(where, Object, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Kurobozu";
                    });
                end;
            elseif where == "Vil/Ohaguro" then
                local Object = self:B2C1Get("Workspace.Section4.Monsters.Ohaguro");
                if not Object then return; end; if self:B2C1Validate(Object, "DescendantAdded") then
                    ESPF.ESP(where, Object, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Ohaguro";
                    });
                end;
            elseif where == "Ship/Monsters" then
                local Object = self:B2C1Get("Workspace.Section5.Monsters");
                if not Object then return; end;
                local CHs = GetChildren(Object);
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        if self:B2C1Validate(v, "DescendantAdded") then
                            ESPF.ESP(where, v, {
                                Color = RED;
                                Size = VEC10;
                                Text = v.Name;
                            });
                        end;
                    end;
                end;
            end; ESPF.Visible(where, true, true);
        end;
        Functions.GetFromCook = function(Givers, name)
            local Object = Givers and FindFirstChild(Givers, name);
            if not Object then return; end;
            local Handle = FindFirstChild(Object, "Handle");
            local Prox = Handle and FindFirstChildOfClass(Handle, "ProximityPrompt");
            if not Prox then return; end;
            Tp(HumRSelf, Handle.CFrame, 0.3);
            fireproximityprompt(Prox);
        end;
        Functions.PlaceCoun = function(Counter)
            local CHs = GetChildren(Counter); for i=1, #CHs do
                local v=CHs[i]; if v.Parent then
                    local Prox = FindFirstChildOfClass(v, "ProximityPrompt");
                    if not Prox then continue; end;
                    Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                    return fireproximityprompt(Prox);
                end;
            end;
        end;
        Functions.ToStove = function(Prox)
            Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
            fireproximityprompt(Prox);
        end;
        Functions.TurnInFood = function(prompt)
            prompt.Parent.Parent.CanCollide = false; prompt.Enabled = true;
            Tp(HumRSelf, prompt.Parent.Parent.CFrame * CFr(0, -3, 0), 0.3);
            fireproximityprompt(prompt);
        end;
        Functions.B2C2Func = function(self, where)
            if where == "Statue" then
                local Object = self:B2C1Get("Workspace.Section1.UmiBozuSeeking_Intro_02");
                if not Object then return; end; local Hitbox = FindFirstChild(Object, "Hitbox_Entrance");
                if FindFirstChild(Hitbox, "TouchInterest") then
                    firetouchinterest(HumRSelf, Hitbox, 0);
                end; Tween({
                    primary = HumRSelf;
                    goal = {CFrame = CFr(-520, 30, -87.29)};
                }); Tp(HumRSelf, CFr(-520, 30, -87.2), 0.3);
                Anchored(HumRSelf, true);
                Tp(HumRSelf, CFr(-520, 30, -87.2), 30);
                Anchored(HumRSelf, false);
                Tp(HumRSelf, CFr(-551, 30, -87.29));
            elseif where == "Crounch" then
                local DoorA = self:B2C1Get("Workspace.Section2.Build.ProxDoorA.DoorFrame.ProximityPrompt"); if DoorA then
                    Tp(HumRSelf, DoorA.Parent.CFrame, 0.3);
                    fireproximityprompt(DoorA); ForceFloat = true;
                    repeat twait(0.1) until self:B2C1Get("Workspace.Section2.Build.ProxDoorB.DoorFrame");
                    local DoorB = self:B2C1Get("Workspace.Section2.Build.ProxDoorB.DoorFrame.ProximityPrompt");
                    if DoorB then
                        Tp(HumRSelf, DoorB.Parent.CFrame, 0.3);
                        fireproximityprompt(DoorB);
                    end; ForceFloat = false;
                end; Tp(HumRSelf, CFr(-3952.85, 700, 317.7), 70);

                local DoorL = self:B2C1Get("Workspace.Section2.TeleportDoor.PROMPTINHERE.ProximityPrompt");
                if not DoorL then return; end;
                Tp(HumRSelf, DoorL.Parent.CFrame, 0.3);
                fireproximityprompt(DoorL);
            elseif where == "Meat/Talk" then
                Tp(HumRSelf, CFr(-4443, 711, 1164)); WindUI:Notify({
                    Title = "<font color='rgb(255,0,0)'>ALERT</font>",
                    Content = "If you just collected meats, wait 11 seconds before talk to this NPC",
                    Icon = "circle-alert",
                    Duration = 11,
                });
            elseif where == "Meat/TpMeat" then
                local MeatRF = self:B2C1Get("Workspace.Section2.Rooms");
                if not MeatRF then return; end;
                for _, v in pairs(GetChildren(MeatRF)) do
                    if v.Name == "RestaurantRoom" then
                        local MeatF = FindFirstChild(v, "Meat");
                        if MeatF then
                            local MeatFChild = GetChildren(MeatF);
                            for i=1, #MeatFChild do
                                if MeatFChild[i].Transparency == 0 then
                                    return CommonF.Tp(HumRSelf, MeatFChild[i].CFrame);
                                end;
                            end;
                        end;
                    end;
                end;
            elseif where == "Meat/Exit" then
                local Object = self:B2C1Get("Workspace.Section2.Rooms.EndRoom.DoorTele.DoorFrame.ProximityPrompt");
                if not Object then return; end;
                Tp(HumRSelf, Object.Parent.CFrame, 0.3);
                fireproximityprompt(Object);
            elseif where == "Meat/Run" then
                ForceFloat = false; Tp(HumRSelf, CFr(-4590, 843.64, -35.54));
                twait(14); ForceFloat = true; tk.spawn(function()
                    Tween({primary = HumRSelf; goal = {CFrame = CFr(-5364, 682.12, 29.63)}});
                end); twait(2); ForceFloat = "None";
            elseif where == "Lever/Enter" then
                Tp(HumRSelf, CFr(-11035, -81.4, -12.56));
            elseif where == "Lever/Auto" then
                local Object = self:B2C1Get("Workspace.Section3.GATE_SYSTEM_01.Levers");
                if not Object then return; end; local CHs = GetChildren(Object);
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Lever = FindFirstChild(v, "Lever");
                        local Prox = Lever and FindFirstChildOfClass(Lever, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Lever.CFrame, 0.3);
                        fireproximityprompt(Prox);
                    end;
                end; return twait(6), Tp(HumRSelf, CFr(-10060, 484.1, -9.52));
            elseif where == "Math" then
                Tp(HumRSelf, CFr(-2005.8, 968.25, -4909.48));
            elseif where == "Cook/Run" then
                return Tween({primary = HumRSelf; goal = {
                    CFrame = CFr(-3345.78, 1205, -6794.84)};
                    info = TweenInfo.new(
                        3,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    )
                }), twait(4), Tp(HumRSelf, CFr(-3347.32, 1205, -6824));
            elseif where == "Cursed/1" then
                Tween({primary = HumRSelf; goal = {CFrame = CFr(-4250.71, 613.7, -968.13)}});
            elseif where == "Cursed/2" then
                Tween({primary = HumRSelf; goal = {CFrame = CFr(-4079.71, 613.7, -968.13)}});
            elseif where == "Cursed/Remove" then
                local Object = self:B2C1Get("Workspace.Section3.5.GAMESTART");
                if not Object then return; end;
                Object.CanTouch = false;
            elseif where == "Kid/Find" then
                local Object = self:B2C1Get("Workspace.Section4.Daughter.IndicatorPic");
                if not Object then return; end;
                Tp(HumRSelf, Object.CFrame, 0.3);
                Tp(HumRSelf, CFr(-4334.81299, 690.94397, -2363.2771));
            elseif where == "Kid/Gate" then
                local Object = self:B2C1Get("Workspace.Section4.Door.Glowing");
                if not Object then return; end;
                Tp(HumRSelf, Object.CFrame);
            elseif where == "Kid/Notes" then
                local Object = self:B2C1Get("Workspace.Section4.SlenderGame.Notes");
                if not Object then return; end; local CHs = GetChildren(Object);
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChildOfClass(v, "ProximityPrompt");
                        if not Prox and not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end;
            end;
        end;
        Functions.B2C2ESP = function(self, where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "Meat/Ashina" then
                local Object = self:B2C1Get("Workspace.Section2.Monsters.Ashina");
                if not Object then return; end; if self:B2C1Validate(Object, "DescendantAdded") then
                    ESPF.ESP(where, Object, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Ashina";
                    });
                end;
            elseif where == "Meat/Meats" then
                local MeatRF = self:B2C1Get("Workspace.Section2.Rooms");
                if not MeatRF then return; end;
                for _, v in pairs(GetChildren(MeatRF)) do
                    if v.Name == "RestaurantRoom" then
                        local MeatF = FindFirstChild(v, "Meat");
                        if MeatF then
                            local MeatFChild = GetChildren(MeatF);
                            for i=1, #MeatFChild do
                                if MeatFChild[i].Transparency == 0 then
                                    ESPF.ESP(where, MeatFChild[i], {
                                        Color = WHITE;
                                        Size = VEC2;
                                        Text = "Meat";
                                    });
                                end;
                            end;
                        end;
                    end;
                end;
            elseif where == "Lever/Levers" then
                local Object = self:B2C1Get("Workspace.Section3.GATE_SYSTEM_01.Levers");
                if not Object then return; end; local CHs = GetChildren(Object);
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Lever = FindFirstChild(v, "Lever");
                        local Prox = Lever and FindFirstChildOfClass(Lever, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        ESPF.ESP(where, Lever, {
                            Color = WHITE;
                            Size = VEC2;
                            Text = "Lever";
                        });
                    end;
                end;
            elseif where == "Math" then
                local MidANumber, MidBNumber = nil;
                local SymbolsAImage1, SymbolsAImage2 = nil;
                local SymbolsBImage1, SymbolsBImage2 = nil;
                local SymbolsANumber1, SymbolsANumber2 = nil;
                local SymbolsBNumber1, SymbolsBNumber2 = nil;
                local Descen = GetDescendants(W);
                for i,v in ipairs(Descen) do
                    if v.ClassName == "TextLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "MiddleNumber" and v.Parent.Parent.Parent.Name == "SymbolsA" then
                        MidANumber = v.Text;
                    end;
                    if v.ClassName == "TextLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "MiddleNumber" and v.Parent.Parent.Parent.Name == "SymbolsB" then
                        MidBNumber = v.Text;
                    end;
                    if v.ClassName == "ImageLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "SymbolHolder" and v.Parent.Parent.Parent.Name == "SymbolsA" then
                        SymbolsAImage1 = v.Image;
                    end;
                    if v.ClassName == "ImageLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "SymbolHolder" and v.Parent.Parent.Parent.Name == "SymbolsB" then
                        SymbolsBImage1 = v.Image;
                    end;
                end; for i,v in ipairs(Descen) do
                    if v.ClassName == "ImageLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "SymbolHolder" and v.Parent.Parent.Parent.Name == "SymbolsA" then
                        if v.Image ~= SymbolsAImage1 then
                            SymbolsAImage2 = v.Image;
                        end;
                    end;
                    if v.ClassName == "ImageLabel" and v.Parent.ClassName == "SurfaceGui" and v.Parent.Parent.Name == "SymbolHolder" and v.Parent.Parent.Parent.Name == "SymbolsB" then
                        if v.Image ~= SymbolsBImage1 then
                            SymbolsBImage2 = v.Image;
                        end;
                    end;
                end; for i,v in ipairs(Descen) do
                    if v.ClassName == "ImageLabel" and FindFirstChild(v.Parent, "TextLabel") then
                        if v.Image == SymbolsAImage1 then
                            SymbolsANumber1 = v.Parent:WaitForChild("TextLabel").Text;
                        end;
                    end;
                    if v.ClassName == "ImageLabel" and FindFirstChild(v.Parent, "TextLabel") then
                        if v.Image == SymbolsAImage2 then
                            SymbolsANumber2 = v.Parent:WaitForChild("TextLabel").Text;
                        end;
                    end;
                    if v.ClassName == "ImageLabel" and FindFirstChild(v.Parent, "TextLabel") then
                        if v.Image == SymbolsBImage1 then
                            SymbolsBNumber1 = v.Parent:WaitForChild("TextLabel").Text;
                        end;
                    end;
                    if v.ClassName == "ImageLabel" and FindFirstChild(v.Parent, "TextLabel") then
                        if v.Image == SymbolsBImage2 then
                            SymbolsBNumber2 = v.Parent:WaitForChild("TextLabel").Text;
                        end;
                    end;
                end;
                local Answer1 = tostring(MidANumber - (SymbolsANumber1 + SymbolsANumber2));
                local Answer2 = tostring(MidBNumber - (SymbolsBNumber1 + SymbolsBNumber2));
                for i,v in ipairs(Descen) do
                    if v.ClassName == "TextLabel" and v.Parent.Parent.Parent.Name == "Kanji" then
                        for _, sec in ipairs(Descen) do
                            if sec.Name == "SymbolHolder[Empty]" and sec.Parent.Name == "SymbolsA" then
                                if v.Text == Answer1 then
                                    local HackImage1 = v.Parent:Clone();
                                    HackImage1.Parent = sec;
                                end;
                            end;
                            if sec.Name == "SymbolHolder[Empty]" and sec.Parent.Name == "SymbolsB" then
                                if v.Text == Answer2 then
                                    local HackImage2 = v.Parent:Clone();
                                    HackImage2.Parent = sec;
                                end;
                            end;
                        end;
                    end;
                end;
            elseif where == "Kid/Mother" then
                local Object = Functions:B2C1Get("Workspace.Section4.Monsters.Mother.HumanoidRootPart");
                if not Object then return; end; if self:B2C1Validate(Object, "DescendantAdded") then
                    ESPF.ESP(where, Object, {
                        Color = RED;
                        Size = VEC10;
                        Text = "Mother";
                    });
                end;
            end; ESPF.Visible(where, true, true)
        end;
        Functions.INVBP = function()
            PSG.Inventory.LocalScript.Enabled = false;
            PSG.Inventory.LocalScript.Enabled = true;
        end;
        Functions.B2C3CanCraft = function(CHs)
            local Count=0; for i=1, #CHs do
                local v=CHs[i]; if v.Parent then
                    if v.Name == "Stick" or v.Name == "Cloth" then
                        Count += 1;
                    end;
                end;
            end; return Count >= 3;
        end;
        Functions.B2C3Click = function(self, name)
            if not tblef(self.OneRunHouseClicked, name) then
                tblein(self.OneRunHouseClicked, name);
                R.Packages.Packet.PacketFunction:InvokeServer(0, {
                    __args = { [1] = name },
                    __tree = { [1] = "IspyService", [2] = "Clicked" },
                    __callType = 0
                }); twait();
            end;
        end;
        Functions.B2C3Func = function(self, where)
            if where == "Gozu" then
                Tp(HumRSelf, CFr(-582, 38, 417));
            elseif where == "Heart/Talk" then
                Tp(HumRSelf, CFr(-138, 45, 79));
            elseif where == "Heart/Auto" then
                local Hearts = GetChildren(W.Section1.Puzzle.Hearts); for i=1, #Hearts do
                    local v=Hearts[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.Heart.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end;
                
                local CHs = GetChildren(W.Section1.Puzzle.SpinModel); for i=1, #CHs do
                    local arm=CHs[i]; if arm.Parent and arm.ClassName == "Model" then
                        local BeatingHeart = FindFirstChild(arm, "BeatingHeart");
                        local Heart = BeatingHeart and FindFirstChild(BeatingHeart, "Heart");
                        local Prox = Heart and FindFirstChild(Heart, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        local BPHeart = FindFirstChild(BP, "Heart"); if BPHeart then
                            HumanoidEquip(HumSelf, BPHeart);
                        end; Tp(HumRSelf, Heart.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end;
            elseif where == "Heart/Run" then
                ForceFloat = true; Tp(HumRSelf, CFr(-101, 42, -395), 0.3);
                local CHs=GetChildren(W.Section1.Maze.Doors2); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Main = FindFirstChild(v, "MAIN");
                        if not Main or dist(Main.Position) > 30 then continue; end;
                        fireproximityprompt(Main.ProximityPrompt); break;
                    end;
                end; ForceFloat = "None";
            elseif where == "Maze/Craft" then
                local Holes = GetChildren(W.Section1.Maze.Holes);
                local Tables = GetChildren(W.Section1.Maze.Crafting.Tables);
                
                ForceFloat = true; for i=1, #Holes do
                    local v=Holes[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);
                    end; if self.B2C3CanCraft(GetChildren(BP)) then break; end;
                end; Tp(HumRSelf, CFr(-78, 4, -442), 1);
                
                for i=1, #Tables do
                    local v=Tables[i]; if v.Parent then
                        local Root = FindFirstChild(v, "RootPart");
                        if dist(Root.Position) > 30 then continue; end;
                        local Prox = FindFirstChild(Root, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Root.CFrame, 0.3);
                        fireproximityprompt(Prox);
                        R.Packages.Packet.PacketFunction:InvokeServer(unpack(ArgsCraft));
                        twait(0.3); PSG.Crafting.Frame.Visible = false; break;
                    end;
                end; ForceFloat = "None";
            elseif where == "Maze/Fire" then
                local Maze = W.Section1.Maze;
                local GrinDemon = if self.GameMode == "Normal" then Maze.GrinDemon else Maze.GrinDemonNM;
                local CHs = GetChildren(Maze.Crafting.ArmFlames); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Flame = FindFirstChild(v, "UndyingFlame");
                        if distOf(Flame, GrinDemon.HumanoidRootPart, 20) then continue; end;
                        local Prox = Flame and FindFirstChild(Flame, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Flame.CFrame, 0.3); fireproximityprompt(Prox); break;
                    end;
                end;
            elseif where == "Maze/Escape" then
                Tp(HumRSelf, CFr(-74, 5.2, -880));
            elseif where == "Bell/Zone" then
                Tp(HumRSelf, CFr(-325.5, 15, -1114));
            elseif where == "Bell/Flys" then
                for amount=1, 2 do
                    local Flies = GetChildren(W.Section2.FlyNoobs.Flies); for i=1, #Flies do
                        local Area=Flies[i]; if Area.Parent then
                            local CHs=GetChildren(Area); for ri=1, #CHs do
                                local v=CHs[ri]; if v.Parent and v.ClassName == "Model" then
                                    local Hitbox = FindFirstChild(v, "FlyHitbox");
                                    if not Hitbox or v.eyes.Transparency == 1 then continue; end;
                                    if self:ToolNow("BoneSword") then
                                        Tp(HumRSelf, Hitbox.CFrame);
                                        self:ToolActive("BoneSword");
                                        twait(3);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            elseif where == "Bell/Auto" then
                local Bells, Colors, IsSoundPlay, Remote = W.Section2.Bells, {
                    Black = Col3.fromRGB(17, 17, 17);
                    White = Col3.fromRGB(248, 248, 248); 
                    Red = Col3.fromRGB(248, 0, 0);
                }, function(sound)
                    return sound.IsPlaying or sound.TimePosition > 0;
                end, R.Packages.Packet.PacketFunction;

                local AddChild = function(Bell)
                    local Buttons = WaitForChild(Bell, "2", 10);
                    local Base = WaitForChild(Buttons, "Base");
                    local Select = WaitForChild(Base, "Select");
                    local PlayerSelect = WaitForChild(Base, "PlayerSelect");
                    local ProximityPrompt = WaitForChild(Base, "ProximityPrompt");
                    local BellModel = WaitForChild(Bell, "BellModel");
                    local BellAnimationController = WaitForChild(BellModel, "AnimationController");
                    local HandMinions = WaitForChild(Bell, "HandMinions");
                    
                    local IsFinished = false; BellAnimationController.AnimationPlayed:Once(function()
                        IsFinished = true;
                    end);

                    local ThreadLoop, Pattern, Threads = false, {}, {};
                    local CHs=GetChildren(Buttons); for i=1, #CHs do
                        local Button=CHs[i]; if Button.Parent and Button.Name == "Buttons" then
                            Threads[#Threads + 1] = PropChangeSignal(Button, "Color"):Connect(function()
                                if Button.Color == Colors.White then
                                    tk.delay(0.1 + math.clamp(self.GetPing(), 0, 0.5), function()
                                        if IsSoundPlay(Select) then
                                            Pattern[#Pattern + 1] = Button;
                                        end;
                                    end);
                                elseif Button.Color == Colors.Red then
                                    Pattern = {};
                                end;
                            end);
                        end;
                    end;

                    Threads[#Threads + 1] = H.Heartbeat:Connect(function()
                        if GetAttribute(HandMinions, "Health") <= 0 or GetAttribute(HandMinions, "CanDamage") then
                            IsFinished = true; tk.defer(function()
                                for i=1, #Threads do
                                    Threads[i]:Disconnect();
                                end;
                            end);
                        end; if IsFinished then
                            return;
                        end; if #Pattern >= 5 and not ThreadLoop then
                            ThreadLoop = true; twait(1 + math.clamp(self.GetPing(), 0, 0.5));
                            for index = 1, #Pattern do
                                local Button = Pattern[index];
                                Remote:InvokeServer(0, {
                                    __args = {[1] = Button,},
                                    __tree = {
                                        [1] = "PuzzleService",
                                        [2] = "Clicked",
                                    }, __callType = 0,
                                }); twait(0.03);
                            end; Remote:InvokeServer(0, {
                                __args = {},
                                __tree = {
                                    "PuzzleService",
                                    "ExitPuzzle"
                                }, __callType = 0
                            }); twait(0.3); Pattern = {}; ThreadLoop = false;
                        end;
                    end);
                end;

                local CHs = GetChildren(Bells); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        AddChild(v);
                    end;
                end;

                local DodoMeki = W.Section2.Monster.Dodomeki.Head; repeat 
                    local AllCompleted = true;
                        local CHs = GetChildren(Bells); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Obj2 = FindFirstChild(v, "2");
                            local HandMinions = FindFirstChild(v, "HandMinions");
                            if not Obj2 or not HandMinions then continue; end;
                            local Base = FindFirstChild(Obj2, "Base");
                            local Prompt = Base and FindFirstChild(Base, "ProximityPrompt");
                            local Hitbox = FindFirstChild(HandMinions, "Hitbox1");
                            
                            if Prompt and Hitbox and GetAttribute(HandMinions, "Health") > 0 then
                                AllCompleted = false; while GetAttribute(HandMinions, "Health") > 0 and v.Parent do
                                    if DodoMeki.CFrame.Position.Y <= 60 then return; end;
                                    if not GetAttribute(HandMinions, "CanDamage") then
                                        Tp(HumRSelf, Base.CFrame, 0.5);
                                        if Prompt.Enabled then
                                            fireproximityprompt(Prompt);
                                            twait(5.3);
                                        end;
                                    elseif not PSG.QuickTime.GrabbedUI.Visible then
                                        if self:ToolNow("BoneSword") then
                                            Tp(HumRSelf, Hitbox.CFrame);
                                            self:ToolActive("BoneSword");
                                        end;
                                    end; twait(0.1);
                                end;
                            end;
                        end;
                    end; twait(1);
                until DodoMeki.Head.CFrame.Position.Y <= 60 or AllCompleted;
            elseif where == "Bell/Puzzle" then
                local CHs=GetChildren(W.Section2.PuzzleDoor.Doors); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Shapes = FindFirstChild(v, "Shapes");
                        local Combos = Shapes and FindFirstChild(Shapes, "Combos");
                        if not Combos or Combos.Position.Y < 0 then continue; end;
                        local SurfaceGui = FindFirstChild(Combos, "SurfaceGui");
                        if not SurfaceGui then continue; end;
                        local CHs2 = GetChildren(SurfaceGui);
                        if #CHs2 == 0 then continue; end;
                        local rv={}; for ri=1, #CHs2 do
                            tblein(rv, CHs2[ri].Name);
                        end; Tp(HumRSelf, Combos.CFrame, 0.3);
                        fireproximityprompt(v.DoorDetector.ProximityPrompt);
                        return R.Packages.Packet.PacketFunction:InvokeServer(0, {
                            __args = {[1] = rv},
                            __tree = {
                                [1] = "DoorPuzzleService",
                                [2] = "Clicked",
                            },
                            __callType = 0,
                        });
                    end;
                end;
            elseif where == "Bell/TpDoor" then
                local CHs=GetChildren(W.Section2.PuzzleDoor.Doors); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Shapes = FindFirstChild(v, "Shapes");
                        local Combos = Shapes and FindFirstChild(Shapes, "Combos");
                        if not Combos or Combos.Position.Y < 0 then continue; end;
                        local SurfaceGui = FindFirstChild(Combos, "SurfaceGui");
                        if not SurfaceGui then continue; end;
                        local CHs2 = GetChildren(SurfaceGui);
                        if #CHs2 == 0 then continue; end;
                        return Tp(HumRSelf, Combos.CFrame, 0.3);
                    end;
                end;
            elseif where == "Bell/Run" then
                Tp(HumRSelf, CFr(-3888, -55, -2289));
            elseif where == "Enzukai/Enter" then
                local CHs = { W["Section2.5"].MindGame.Intro.Trigger, W["Section2.5"].MindGame.Intro.Trigger2 };
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        Tp(HumRSelf, v.CFrame, 0.3);
                    end;
                end;
            elseif where == "Enzukai/Auto" then
                local CHs = GetChildren(W["Section2.5"].MindGame.Boats); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Assign = FindFirstChild(v, "AssignedPlayer");
                        if Assign.Value ~= selff then continue; end;
                        local Enzukai = FindFirstChild(v, "EnzukaiGame");
                        local Root = Enzukai and FindFirstChild(Enzukai, "RootPart");
                        local ProxAt = Root and FindFirstChild(Root, "PromptAttachment");
                        local Prox = ProxAt and FindFirstChild(ProxAt, "ProximityPrompt");
                        while Prox and Prox.Parent and Enzukai.Parent do
                            if Prox.Enabled then
                                fireproximityprompt(Prox);
                            end; twait(0.1);
                        end; break;
                    end;
                end;
            elseif where == "Father/Isamu" then
                W.Section3.IsamuAI.Hitbox.CanTouch = false;
            elseif where == "Father/Auto" then
                Tp(HumRSelf, CFr(1136, 30, -2400));
            elseif where == "Train" then
                Tp(HumRSelf, W["Section3.5"].GhostTrain.TrainTrigger.CFrame);
            elseif where == "Larves" then
                local Dog = W.Section4.DogWall.RootPart.ProximityPrompt;
                local CHs = GetChildren(W.Section4.HotPotato.Givers); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Root = FindFirstChild(v, "RootPart");
                        local Prox = Root and FindFirstChild(Root, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Root.CFrame, 0.3); fireproximityprompt(Prox); break;
                    end;
                end; Tp(HumRSelf, Dog.Parent.CFrame, 0.3); fireproximityprompt(Dog);
            elseif where == "Mud" then
                Tp(HumRSelf, W["Section4.5"].TeleportToSection5.CFrame);
            elseif where == "Yurei/House" then
                local CHs = GetChildren(W.Section5.ISPY.Houses); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Player = FindFirstChild(v, "Player");
                        local Root = Player and FindFirstChild(Player, "HumanoidRootPart");
                        local Prox = Root and FindFirstChild(Root, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Root.CFrame, 0.3); fireproximityprompt(Prox); break;
                    end;
                end;
            elseif where == "Yurei/Click" then
                local CHs = GetChildren(W.Section5.ISPY.Houses); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Player = FindFirstChild(v, "Player");
                        local Root = Player and FindFirstChild(Player, "HumanoidRootPart");
                        if dist(Root.Position) > 50 then continue; end;

                        local Items = GetChildren(v.Items); for index=1, #Items do
                            local ItemName, Text = Items[index].Name, PSG.Section5.TextLabel.Text;
                            if strfind(Text, ItemName) then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Teddy Bear") and ItemName == "TeddyBear" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Traditional Lantern") and ItemName == "TraditionalLantern" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Japanese Stone Lantern") and ItemName == "JapaneseStoneLantern" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Rubber Duck") and ItemName == "RubberDuck" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Working Lantern") and ItemName == "WorkingLantern" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Sun Symbol") and ItemName == "SunSymbol" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Kintoru Head") and ItemName == "KintoruHead" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Mail Box") and ItemName == "MailBox" then
                                self:B2C3Click(ItemName, v.Name);
                            elseif strfind(Text, "Rice Barrel") and ItemName == "RiceBarrel" then
                                self:B2C3Click(ItemName, v.Name);
                            end; twait(0.3);
                        end;
                    end;
                end;
            elseif where == "Boss/TpSafe" then
                if self:B2C3Func("Boss/Map") then
                    Tp(HumRSelf, CFr(3078, 17, -540));
                end;
            elseif where == "Boss/Map" then
                if self.MapC then return true; end; self.MapC = true;
                local CHs = GetChildren(W.Section5.Boss.Build); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        if v.Name == "c01-15k" or v.Name == "InvisWall" then
                            v:Destroy();
                        end;
                    end;
                end; return true;
            elseif where == "Boss/Katanas" then
                if self:B2C3Func("Boss/Map") then
                    local CHs, CO = GetChildren(W.Section5.Boss.Katanas), 0; for i=1, #CHs do
                        if CO > 4 then return; end; ForceFloat = true;
                        local v=CHs[i]; if v.Parent and v.Transparency == 0 then
                            Tp(HumRSelf, v.CFrame * CFr(15,0,0), 0.3);
                            fireproximityprompt(v.ProximityPrompt); CO+=1;
                        end; ForceFloat = "None";
                    end; Functions:B2C3Func("Boss/TpSafe");
                end;
            elseif where == "Hell/Run" then
                Tp(HumRSelf, CFr(-1697, 246, 7806));
            end;
        end;
        Functions.B2C3ESP = function(self, where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "Maze/GrinDemon" then
                local Maze = W.Section1.Maze;
                local GrinDemon = if self.GameMode == "Normal" then Maze.GrinDemon else Maze.GrinDemonNM;
                if not GrinDemon then return; end;
                ESPF.ESP(where, GrinDemon, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Grin Demon";
                });
            elseif where == "Larves/Larves" then
                local CHs = GetChildren(W.Section4.HotPotato.Givers); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Root = FindFirstChild(v, "RootPart");
                        local Prox = Root and FindFirstChild(Root, "ProximityPrompt");
                        if not Prox then continue; end;
                        local ESPObject = ESPF.ESP(where, Root, {
                            Color = if Prox.Enabled then YELLOW else GREEN;
                            Size = VEC2;
                            Text = "Larves";
                        }); if not ESPObject.ChangeSignal then
                            ESPObject.ChangeSignal = PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(if Prox.Enabled then YELLOW else GREEN);
                            end);
                        end;
                    end;
                end;
            elseif where == "Larves/Soldier" then
                local CMs = {
                    W.Section4.StatueMonsters.Left,
                    W.Section4.StatueMonsters.Right,
                }; for i=1, #CMs do
                    local CHs = GetChildren(CMs[i]); for ri=1, #CHs do
                        local v=CHs[ri]; if v.Parent then
                            ESPF.ESP(where, v, {
                                Color = RED;
                                Size = VEC10;
                                Text = "Soldier";
                            });
                        end;
                    end;
                end;
            elseif where == "Larves/Boogey" then
                local BoogeymanAI = FindFirstChild(W.Section4.Monster, "BoogeymanAI");
                if not BoogeymanAI then return; end;
                ESPF.ESP(where, BoogeymanAI, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Boogeyman";
                });
            end; ESPF.Visible(where, true, true);
        end;
        Functions.B2C4BP1 = function()
            local ScreenGui = FindFirstChild(PSG, "ScreenGui");
            if ScreenGui then
                ScreenGui.Enabled = false;
                
                local Frame = FindFirstChild(ScreenGui, "Frame");
                if Frame then Frame.Visible = false; end;
            end;

            local Remote = FindFirstChild(W.Section1.PlayerObjective, "Remote");
            if Remote then Remote:FireServer(1); end;
        end;
        Functions.B2C4BP2 = function()
            -- Services
            local RunService = game:GetService("RunService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")

            -- Dependencies
            local spr = require(ReplicatedStorage._Libraries.spr)
            local Controllers = require(ReplicatedStorage.Client.Controllers)

            local script = game:GetService("Players").LocalPlayer.PlayerGui["S2.5"].LocalScript;
            local Section = workspace:WaitForChild("Section2.5")
            local TriviaGame = Section:WaitForChild("ChihiroMinigame"):WaitForChild("Trivia")
            local MonsterMother = TriviaGame:WaitForChild("Monster", math.huge):WaitForChild("Mother", math.huge)
            local SignalRemote = TriviaGame:WaitForChild("Signal")
            local TriviaUI = script.Parent

            -- Creates a corner element for the trivia UI with animated frames
            local function CreateCornerElement(isTop, isLeft)
                local canvasGroup = Instance.new("CanvasGroup")
                canvasGroup.BackgroundTransparency = 1
                canvasGroup.BorderSizePixel = 0
                canvasGroup.ZIndex = 2
                canvasGroup.Size = UDim2.fromScale(0.5, 0.5)
                canvasGroup.Position = UDim2.fromScale(isLeft and 0 or 1, isTop and 0 or 1)
                canvasGroup.Name = ""

                local aspectRatio = Instance.new("UIAspectRatioConstraint")
                aspectRatio.AspectRatio = 1
                aspectRatio.Parent = canvasGroup

                local function CreateFrame(isHorizontal)
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.fromScale(isHorizontal and 1 or 0.1, isHorizontal and 0.1 or 1)
                    frame.BorderSizePixel = 0
                    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    frame.Name = ""

                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0.5, 0)
                    corner.Parent = frame
                    return frame
                end

                local horizontalFrame = CreateFrame(false)
                horizontalFrame.Position = UDim2.fromScale(isLeft and 0 or 1, 0)
                horizontalFrame.AnchorPoint = Vector2.new(isLeft and 0 or 1, 0)
                horizontalFrame.Parent = canvasGroup

                local verticalFrame = CreateFrame(true)
                verticalFrame.Position = UDim2.fromScale(0, isTop and 0 or 1)
                verticalFrame.AnchorPoint = Vector2.new(0, isTop and 0 or 1)
                verticalFrame.Parent = canvasGroup

                return {
                    group = canvasGroup,
                    x = horizontalFrame,
                    y = verticalFrame,
                    top = isTop,
                    left = isLeft
                }
            end

            -- Creates a folder with animated corner elements
            local function CreateCornerFolder(parent)
                local folder = Instance.new("Folder")
                folder.Name = ""

                local cornerData = { corners = {} }

                for i = 1, 4 do
                    local corner = CreateCornerElement(i < 3, i % 2 ~= 0)
                    local group = corner.group
                    local offset = Vector2.new(0, 0)
                    group.AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                        offset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1)
                    group.GroupTransparency = 1
                    group.Parent = folder
                    table.insert(cornerData.corners, corner)
                end

                function cornerData:animatePop()
                    for _, corner in self.corners do
                        local animOffset = Vector2.new(0.2, 0.2)
                        spr.target(corner.group, 0.5, 2, {
                            AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                                animOffset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1)
                        })
                        task.delay(0.25, function()
                            local nextOffset = Vector2.new(0.25, 0.25)
                            spr.target(corner.group, 0.5, 3, {
                                AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                                    nextOffset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1)
                            })
                        end)
                    end
                end

                function cornerData:animateIn()
                    for _, corner in self.corners do
                        local animOffset = Vector2.new(0, 0)
                        spr.target(corner.group, 1, 2, {
                            AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                                animOffset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1),
                            GroupTransparency = 1
                        })
                    end
                end

                function cornerData:animateOut()
                    for _, corner in self.corners do
                        local animOffset = Vector2.new(0.25, 0.25)
                        spr.target(corner.group, 0.9, 2, {
                            AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                                animOffset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1),
                            GroupTransparency = 0
                        })
                    end
                end

                function cornerData:animateOutDrag()
                    for _, corner in self.corners do
                        local animOffset = Vector2.new(0.4, 0.4)
                        spr.target(corner.group, 1, 2, {
                            AnchorPoint = Vector2.new(corner.left and 0 or 1, corner.top and 0 or 1) +
                                animOffset * Vector2.new(corner.left and 1 or -1, corner.top and 1 or -1),
                            GroupTransparency = 0
                        })
                        task.delay(0.1, function()
                            spr.target(corner.group, 1, 3, {
                                GroupTransparency = 1
                            })
                        end)
                    end
                end

                folder.Parent = parent
                return cornerData
            end

            -- Initialize corner animations
            local cornerAnimation1 = CreateCornerFolder(TriviaUI.Questions)
            local cornerAnimation2 = CreateCornerFolder(TriviaUI.Questions)
            local cornerAnimation3 = CreateCornerFolder(TriviaUI.Questions)

            -- Button and animation management
            local buttons = {}
            local buttonCallbacks = {}
            local isInteractionEnabled = true

            -- Reset button states
            local function ResetButtons()
                for _, callback in buttonCallbacks do
                    callback()
                end
                for _, buttonData in buttons do
                    spr.stop(buttonData.Button)
                    spr.stop(buttonData.Button.UIStroke)
                    buttonData.Button.BackgroundTransparency = 0.1
                    buttonData.Button.UIStroke.Transparency = 0.3
                    buttonData.Button.UIStroke.Color = Color3.fromRGB(255, 255, 255)
                    buttonData.Button.Size = UDim2.fromScale(1, 1)
                    spr.target(buttonData.Button.UIStroke, 1, 3, {
                        Color = Color3.fromRGB(0, 0, 0)
                    })
                    spr.target(buttonData.Button, 1, 3, {
                        Size = UDim2.fromScale(0.8, 0.8)
                    })
                    buttonData:SetAttribute("Selected", false)
                end
            end

            -- Set up button interactions
            for index, buttonFrame in TriviaUI.Selectors:GetChildren() do
                if buttonFrame:IsA("Frame") then
                    local function UpdateButtonState()
                        local isSelected = buttonFrame:GetAttribute("Selected")
                        spr.target(buttonFrame.Button.UIStroke, 1, 3, {
                            Color = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
                        })
                        spr.target(buttonFrame.Button, 1, 3, {
                            Size = isSelected and UDim2.fromScale(0.9, 0.9) or UDim2.fromScale(0.8, 0.8)
                        })
                    end

                    table.insert(buttonCallbacks, UpdateButtonState)
                    buttonFrame:GetAttributeChangedSignal("Selected"):Connect(UpdateButtonState)

                    buttonFrame.Button.Activated:Connect(function()
                        if not isInteractionEnabled then
                            isInteractionEnabled = true
                            SignalRemote:FireServer(1, index)
                            buttonFrame:SetAttribute("Selected", true)
                            cornerAnimation1:animatePop()
                            task.wait(0.4)
                            cornerAnimation1:animateIn()
                        end
                    end)

                    table.insert(buttons, buttonFrame)
                end
            end

            -- Store initial button positions
            local buttonPositions = {}
            for index, button in buttons do
                buttonPositions[index] = {
                    Position = button.Position,
                    AnchorPoint = button.AnchorPoint,
                    From = button
                }
            end

            -- Trivia game state
            local timerValue = 0
            local isGlitchActive = false

            -- Main trivia game function
            local function StartTriviaGame(questionText, answers, glitchEnabled)
                if isInteractionEnabled then
                    task.delay(0.1, function()
                        cornerAnimation2:animateOutDrag()
                        task.wait(0.1)
                        cornerAnimation3:animateOutDrag()
                        task.wait(0.6)
                        cornerAnimation2:animateIn()
                        cornerAnimation3:animateIn()
                    end)
                end

                TriviaUI.Questions.Visible = true
                TriviaUI.Selectors.Visible = true
                isInteractionEnabled = false
                ResetButtons()
                isGlitchActive = glitchEnabled or false

                for _, buttonData in buttonPositions do
                    buttonData.From.Position = buttonData.Position
                    buttonData.From.AnchorPoint = buttonData.AnchorPoint
                end

                if timerValue == 0 then
                    task.defer(function()
                        while timerValue > 0 do
                            task.wait(1)
                            TriviaUI.Questions.Timer.Text = tostring(timerValue)
                            if isGlitchActive and (timerValue % 5 == 0 and #buttonPositions > 1) then
                                script.GlitchSFX:Play()
                                local index1 = math.random(1, #buttonPositions)
                                local index2
                                repeat
                                    index2 = math.random(1, #buttonPositions)
                                until index2 and index2 ~= index1

                                local button1 = buttonPositions[index1]
                                local button2 = buttonPositions[index2]
                                local tempPos = button2.From.Position
                                local tempAnchor = button2.From.AnchorPoint
                                button2.From.Position = button1.From.Position
                                button2.From.AnchorPoint = button1.From.AnchorPoint
                                button1.From.Position = tempPos
                                button1.From.AnchorPoint = tempAnchor
                                button1.From.Button.Label.TextColor3 = Color3.fromRGB(0, 123, 255)
                                button2.From.Button.Label.TextColor3 = Color3.fromRGB(0, 123, 255)
                                task.delay(0.08333333333333333, function()
                                    button1.From.Button.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    button2.From.Button.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                                end)
                            end
                            timerValue = timerValue - 1
                        end
                    end)
                end

                timerValue = 20
                TriviaUI.Questions.Timer.Text = tostring(timerValue)
                cornerAnimation1:animateOut()
                cornerAnimation1:animatePop()
                spr.target(TriviaUI.Questions, 1, 3, {
                    BackgroundTransparency = 0.2
                })
                spr.target(TriviaUI.Questions.UIStroke, 1, 3, {
                    Transparency = 0.3
                })
                spr.target(TriviaUI.Questions.Question, 1, 3, {
                    TextTransparency = 0
                })
                spr.target(TriviaUI.Questions.Question.UIStroke, 1, 3, {
                    Transparency = 0
                })
                TriviaUI.Questions.Question.Text = questionText

                for index, answer in answers do
                    buttons[index].Button.Label.Text = answer
                end
            end

            -- Camera control
            local CurrentCamera = workspace.CurrentCamera
            local cameraConnection = nil

            local function UpdateCamera()
                if TriviaGame:GetAttribute("Game") then
                    if not (cameraConnection and cameraConnection.Connected) then
                        cameraConnection = RunService.Heartbeat:Connect(function()
                            local cameraCFrame = CFrame.new(CurrentCamera.CFrame.Position, MonsterMother:GetPivot().Position + Vector3.new(0, 3, 0))
                            local x, y, _ = cameraCFrame:ToOrientation()
                            Controllers.camera:Enforce(Vector2.new(math.deg(x), math.deg(y)))
                        end)
                    end
                else
                    if cameraConnection then
                        cameraConnection:Disconnect()
                        cameraConnection = nil
                    end
                    return
                end
            end

            -- Initialize
            TriviaGame:GetAttributeChangedSignal("Game"):Connect(UpdateCamera)
            UpdateCamera()

            -- Set initial UI transparency
            TriviaUI.Questions.BackgroundTransparency = 1
            TriviaUI.Questions.UIStroke.Transparency = 1
            TriviaUI.Questions.Question.TextTransparency = 1
            TriviaUI.Questions.Question.UIStroke.Transparency = 1

            -- Handle remote events
            SignalRemote.OnClientEvent:Connect(function(eventType, ...)
                if eventType == 0 then
                    StartTriviaGame(...)
                elseif eventType == 1 then
                    spr.target(TriviaUI.Questions, 1, 3, {
                        BackgroundTransparency = 1
                    })
                    spr.target(TriviaUI.Questions.UIStroke, 1, 3, {
                        Transparency = 1
                    })
                    spr.target(TriviaUI.Questions.Question, 1, 3, {
                        TextTransparency = 1
                    })
                    spr.target(TriviaUI.Questions.Question.UIStroke, 1, 3, {
                        Transparency = 1
                    })
                    TriviaUI.Selectors.Visible = false
                elseif eventType == 2 then
                    TriviaUI:Destroy()
                elseif eventType == 3 then
                    local isCorrect = ...
                    if isCorrect then
                        TriviaGame.Correct:Play()
                    else
                        TriviaGame.Wrong:Play()
                    end
                end
            end)
        end;
        Functions.GetBowLook = function(pos, spr)
            if not spr then return; end;
            local eye = spr.Handle.MagicArrow.CFrame.Position;
            return CFr(eye, pos).LookVector;
        end;
        Functions.MagicArrowHit = function(self, Bow, Pos, cd)
            if not Bow or self.OnGoingArrow then return; end;
            self.OnGoingArrow = true;
            Bow.RemoteEvent:FireServer(0, true);
            twait(cd or 1);
            Bow.RemoteEvent:FireServer(0, false, self.GetBowLook(Pos, Bow));
            self.OnGoingArrow = false;
        end;
        Functions.B2C4Func = function(self, where)
            if where == "Cave" then
                Tp(HumRSelf, W.Section0.Cutscene.Trigger.CFrame);
            elseif where == "City/Auto" then
                Tp(HumRSelf, W.Section1.EnzukaiSneakSequence.GameStart.CFrame, 0.3);
                Tp(HumRSelf, W.Section1.OfficeTeleA.CFrame);
            elseif where == "City/Glass" then
                local CHs = GetChildren(W.Section1.EnzukaiSneakSequence.Activators); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        v:Destroy();
                    end;
                end;
            elseif where == "Office/Talk" then
                Tp(HumRSelf, CFr(4449, 44, 1660));
            elseif where == "Office/Auto" then
                local Numbs = W.Section1.PlayerObjective.CodeNumbers;
                local codextxt = {
                    [6] = Numbs["1stFloor"].SurfaceGui.Random,
                    [5] = Numbs["2ndFloor"].SurfaceGui.Random,
                    [4] = Numbs["3rdFloor"].SurfaceGui.Random,
                    [3] = Numbs["4thFloor"].SurfaceGui.Random,
                    [2] = Numbs["5thFloor"].SurfaceGui.Random,
                    [1] = Numbs["6thFloor"].SurfaceGui.Random,
                }; W.Section1.PlayerObjective.CodeDoor.Remote:FireServer(1, {});
                local c = {}; for i=1, 6 do
                    tblein(c, tonumber(codextxt[i].Text));
                end; return W.Section1.PlayerObjective.CodeDoor.Remote:FireServer(1, c);
            elseif where == "Office/Top" then
                local CHs = GetChildren(W.Section1.Map.Barriers); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        v:Destroy();
                    end;
                end;

                local PieceA = W.WHITE_FLAME_LANTERN.PieceA;
                local Ladder = W.Section1.PlayerObjective.LADDERPROMPT;

                Tp(HumRSelf, PieceA.CFrame, 0.3); fireproximityprompt(PieceA.ProximityPrompt);
                Tp(HumRSelf, Ladder.CFrame, 0.3); fireproximityprompt(Ladder.ProximityPrompt);
            elseif where == "Mall/Talk" then
                local CHs = GetChildren(W.Section2.WalkieTalkis); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "WalkieTalkie" then
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(v.ProximityPrompt);
                    end;
                end;
            elseif where == "Mall/Trigger" then
                Tp(HumRSelf, W.Section2.Floor1.TRIGGER.CFrame);
            elseif where == "Mall/Eyes" then
                local folders = GetChildren(W.Section2.Floor1.TimedTrial); for i=1, #folders do
                    local folder=folders[i]; if not folder.Parent or folder.ClassName ~= "Folder" then
                        continue; 
                    end; local CHs = GetChildren(folder); for ir=1, #CHs do
                        local v=CHs[ir]; if v.Parent and v.Name == "EyePunch" then
                            local Root = FindFirstChild(v, "RootPart"); if not Root then continue; end;
                            local Prox = FindFirstChild(Root, "ProximityPrompt"); if not Prox then continue; end;
                            Tp(HumRSelf, Root.CFrame, 0.3); fireproximityprompt(Prox);
                        end;
                    end;
                end;
            elseif where == "Mall/Grab" then
                local Base = W.Section2.Speaker.SPEAKER;
                Tp(HumRSelf, Base.CFrame, 0.3);
                fireproximityprompt(Base["Pick Up"]);
            elseif where == "Mall/Place" then
                Tp(HumRSelf, CFr(-1351, -120, -942), 0.3);
                W.Section2.Speaker.Signal:FireServer();
            elseif where == "Mall/Chase1" then
                local CHs = {
                    CFr(-2925, -154, -117);
                    CFr(-2925, -152, 20);
                    CFr(-2971, -153, 90);
                    CFr(-3010, -156, 58);
                    CFr(-3010, -157, 1);
                    CFr(-3075, -161, 0);
                    CFr(-3078, -156, 44);
                    CFr(-3147, -163, 67);
                    CFr(-3156, -165, 6);
                    CFr(-3231, -169, 8);
                    CFr(-3325, -174, 8);
                    CFr(-3373, -177, -8);
                    CFr(-3452, -182, -41);
                    CFr(-3444, -182, -88);
                    CFr(-3424, -182, -148);
                    CFr(-3393, -181, -212);
                    CFr(-3353, -181, -297);
                    CFr(-3319, -180, -374);
                    CFr(-3343, -183, -464);
                    CFr(-3343, -183, -464);
                    CFr(-3401, -186, -505);
                    CFr(-3392, -187, -558);
                    CFr(-3441, -191, -584);
                    CFr(-3468, -190, -531);
                    CFr(-3543, -195, -551);
                    CFr(-3582, -197, -524);
                    CFr(-3619, -200, -608);
                    CFr(-3656, -203, -680);
                    CFr(-3710, -208, -784);
                    CFr(-3671, -207, -880);
                    CFr(-3601, -206, -1059);
                    CFr(-3449, -197, -999);
                    CFr(-3449, -197, -999);
                    CFr(-3241, -200, -902);
                }; Tp(HumRSelf, W["Section2.5"].ChaseSequence.StartPoint.CFrame, 0.3);
                local TWEENINFONOW, HumRSelfS = TweenInfo.new(1.3), HumRSelf; for i=1, #CHs do
                    Tween({
                        primary = HumRSelfS;
                        goal = {CFrame=CHs[i]};
                        info = TWEENINFONOW;
                    });
                end; Tween({primary = HumRSelfS, goal = {CFrame = W["Section2.5"].ChaseSequence.EndPoint.CFrame}});
            elseif where == "Mall/Chase2" then
                Tp(HumRSelf, W["Section2.5"].ChaseSequence.SecondChaseStuff.ElevatorHit.CFrame);
            elseif where == "Car/Collect" then
                local CHs, Count = GetChildren(W["Section2.5"].ChihiroMinigame.CarFixObjective.CarParts), 0; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and IsA(v, "BasePart") then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Count = Count + 1;
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(Prox, 1);
                        if Count > 2 then
                            break;
                        end;
                    end;
                end;
                
                local V8 = FindFirstChild(W["Section2.5"].ChihiroMinigame.CarFixObjective.CarParts, "V8 Engine");
                local Base = if V8 then V8["Meshes/ls9_Cube (2)"] else nil; if V8 then
                    Tp(HumRSelf, Base.CFrame, 0.3);
                    fireproximityprompt(Base.ProximityPrompt);
                end; Tp(HumRSelf, CFr(-1924, -96, 1597));
            elseif where == "Car/Answer" then
                if not self.MotherLabels then
                    self.MotherLabels = {
                        PSG["S2.5"].Selectors["3"].Button.Label,
                        PSG["S2.5"].Selectors["2"].Button.Label,
                        PSG["S2.5"].Selectors["1"].Button.Label,
                    };
                end;

                local Answers = self.AnsweredMother;
                local Labels = self.MotherLabels;

                for i,v in pairs(Answers) do
                    if strfind(PSG["S2.5"].Questions.Question.Text, i) then
                        local answer = self.AnsweredMother[i];
                        for ri=1, 3 do
                            local rv=Labels[ri].Text;
                            if rv == answer then
                                W["Section2.5"].ChihiroMinigame.Trivia.Signal:FireServer(1, tonumber(Labels[ri].Parent.Parent.Name));
                                return pcall(function()
                                    TextChatService.TextChannels.RBXGeneral:SendAsync(answer);
                                end);
                            end;
                        end;
                    end;
                end;
            elseif where == "Draw/Outside" then
                Tp(HumRSelf, CFr(-35, -431, 9154));
            elseif where == "Draw/Inside" then
                Tp(HumRSelf, CFr(87, -430, 9267));
            elseif where == "Draw/Tp" then
                local PaintStations=W.Section3.PaintPuzzle;
                local CHs = {
                    PaintStations.PaintStation_A.Pad;
                    PaintStations.PaintStation_B.Pad;
                    PaintStations.PaintStation_C.Pad;
                    PaintStations.PaintStation_D.Pad;
                }; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "Draw");
                        if not Prox or not Prox.Enabled then continue; end;
                        return Tp(HumRSelf, Prox.Parent.CFrame);
                    end;
                end;
            elseif where == "Draw/Draw" then
                local Paints = self.Paints; if not Paints then
                    return WindUI:Notify({
                        Title = "<font color='rgb(255,255,0)'>Installer</font>",
                        Content = "Please download 'Paintings' package from 'Core Settings' tab.",
                        Icon = "circle-alert",
                        Duration = 10,
                    });
                end;
                local CHs = GetChildren(W.Section3.PaintPuzzle); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Pad = FindFirstChild(v, "Pad");
                        if not Pad then continue; end;
                        if dist(Pad.Position) <= 10 then
                            local obj = FindFirstChildWhichIsA(Pad, "Decal");
                            local Text = obj.Texture;
                            local tonn = Text:gsub("rbxassetid://", "");
                            local target = tonumber(tonn);
                            local Pos = self.PaintPoses[target];
                            for _, v in pairs(Paints[target]) do
                                Pad.Controls.Draw:FireServer(Pos, v[1], v[2]);
                            end;
                        end;
                    end;
                end;
            elseif where == "Draw/Pillar" then
                local CHs = GetChildren(W.Section3.MagicPillars); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "Pillar" then
                        if not v.Text.SurfaceGui.Enabled then
                            return Tp(HumRSelf, v.PillarBase.CFrame);
                        end;
                    end;
                end;
            elseif where == "Draw/Item" then
                local CHs = GetChildren(W.WHITE_FLAME_LANTERN.PieceDnE); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        if v.Name == "PieceD" or v.Name == "PieceE" then
                            local Prox = FindFirstChild(v, "ProximityPrompt");
                            if not Prox then continue; end;
                            Tp(HumRSelf, v.CFrame, 0.3);
                            fireproximityprompt(Prox);
                        end;
                    end;
                end;
            elseif where == "Godmode" then
                sethiddenproperty(selff, "MaxSimulationRadius", 10000);
                sethiddenproperty(selff, "SimulationRadius", 10000);

                local CHs = {self.Tsukiya2, self.Rin2, self.Tenome2}; for i=1, #CHs do
                    local v=CHs[i]; if v and v.Parent then
                        local Root = FindFirstChild(v, "HumanoidRootPart");
                        local Hitbox = FindFirstChild(v, "Hitbox");

                        if Root then Root.CanTouch = false; end;
                        if Hitbox then Hitbox.CanTouch = false; end;
                    end;
                end;

                local EnzukaiRyu = FindFirstChild(W.Section4.BossMonster, "EnzukaiRyu");
                EnzukaiRyu = EnzukaiRyu and FindFirstChild(EnzukaiRyu, "Hitbox");

                local Enzukai2 = FindFirstChild(W.Section4.Monster, "Enzukai2");
                Enzukai2 = Enzukai2 and FindFirstChild(Enzukai2, "Hitbox");

                if EnzukaiRyu then EnzukaiRyu.CanTouch = false; end;
                if Enzukai2 then Enzukai2.CanTouch = false; end;
            elseif where == "Survivors" then
                local CHs = GetChildren(W.Section4.Rescue.NPCs); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "Pose" then
                        local Base = FindFirstChild(v, "HumanoidRootPart");
                        local Prox = Base and FindFirstChild(Base, "ProximityPrompt");
                        Tp(HumRSelf, Base.CFrame, 0.3); fireproximityprompt(Prox);
                        if i>4 then break; end;
                    end;
                end; Tp(HumRSelf, CFr(-98, 3, -2338));
            end;
        end;
        Functions.B2C4ESP = function(self, where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "City/Glass" then
                local CHs = GetChildren(W.Section1.EnzukaiSneakSequence.Activators); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC2;
                            Text = "Glass";
                        });
                    end;
                end;
            elseif where == "City/Enzukai" then
                ESPF.ESP(where, W.Section1.EnzukaiSneakSequence.Monster.Enzukai, {
                    Color = RED;
                    Size = VEC2;
                    Text = "Enzukai";
                });
            elseif where == "Mall/Coins" then
                local CHs = GetChildren(W.Section2.Floor2.Coins); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox then continue; end;
                        local ESPObject = ESPF.ESP(where, v, {
                            Color = if not Prox.Enabled then GREEN else YELLOW;
                            Size = VEC2;
                            Text = "Coin";
                        }); if not ESPObject.ChangeSignal then
                            ESPObject.ChangeSignal = PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(if not Prox.Enabled then GREEN else YELLOW);
                            end);
                        end;
                    end;
                end;
            elseif where == "Mall/Talk" then
                local CHs = GetChildren(W.Section2.WalkieTalkis); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "WalkieTalkie" then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox then continue; end;
                        ESPF.ESP(where, v, {
                            Color = WHITE;
                            Size = VEC2;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "Mall/Monsters" then
                local CHs = {
                    W.Section2.Floor3.Monster.Tsukiya;
                    W.Section2.Floor1.Monster.Tenome;
                    W.Section2.Floor2.Monster.Rin;
                }; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC10;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "Draw/Senzai" then
                local Senzai = FindFirstChild(W.Section3.Monster, "Senzai");
                if not Senzai then return; end; ESPF.ESP(where, Senzai, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Senzai";
                });
            elseif where == "Draw/Ingredients" then
                local CHs = GetChildren(W.Section3.PaintPuzzle.Ingredients); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local ESPObject, Prox = nil, FindFirstChild(v, "ProximityPrompt");
                        if not Prox then continue; end; if v.Name == "Orchid" then
                            ESPObject = ESPF.ESP(where, v, {
                                Color = if Prox.Enabled then PURPLE else WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        elseif v.Name == "Water" then
                            ESPObject = ESPF.ESP(where, v, {
                                Color = if Prox.Enabled then BLUE else WHITE;
                                Size = VEC2;
                                Text = v.Name;
                            });
                        end; if ESPObject and not ESPObject.ChangeSignal then
                            ESPObject.ChangeSignal = PropChangeSignal(Prox, "Enabled"):Connect(function()
                                if not Prox.Enabled then return ESPObject.UpdateColor(WHITE); end;
                                if v.Name == "Orchid" then
                                    ESPObject.UpdateColor(PURPLE);
                                else
                                    ESPObject.UpdateColor(BLUE);
                                end;
                            end);
                        end;
                    end;
                end;
            elseif where == "Draw/Drawings" then
                local PaintStations=W.Section3.PaintPuzzle;
                local CHs = {
                    PaintStations.PaintStation_A.Pad;
                    PaintStations.PaintStation_B.Pad;
                    PaintStations.PaintStation_C.Pad;
                    PaintStations.PaintStation_D.Pad;
                }; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "Draw");
                        if not Prox then continue; end;
                        local ESPObject = ESPF.ESP(where, v, {
                            Color = if Prox.Enabled then YELLOW else GREEN;
                            Size = VEC2;
                            Text = v.Name;
                        }); if not ESPObject.ChangeSignal then
                            ESPObject.ChangeSignal = PropChangeSignal(Prox, "Enabled"):Connect(function()
                                ESPObject.UpdateColor(if Prox.Enabled then YELLOW else GREEN);
                            end);
                        end;
                    end;
                end;
            elseif where == "Survivors" then
                local CHs = GetChildren(W.Section4.Rescue.NPCs); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "Pose" then
                        ESPF.ESP(where, v, {
                            Color = GREEN;
                            Size = VEC2;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "Followers" then
                local CHs = {self.Tsukiya2, self.Rin2, self.Tenome2}; for i=1, #CHs do
                    local v=CHs[i]; if v and v.Parent then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC10;
                            Text = v.Name;
                        });
                    end;
                end;
            end; ESPF.Visible(where, true, true);
        end;
        Functions.B3C1Func = function(self, where)
            if where == "City/Kill" then
                local CHs=GetChildren(W.Section1.Grunts); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                        local sRE = FindFirstChild(v, "RemoteEvent");
                        if not sRE then continue; end;
                        while v.Parent and sRE.Parent do
                            if self:ToolNow("Gun") then
                                local Pivot = GetPivot(v);
                                Tp(HumRSelf, Pivot*CFr(0, 40, 0));
                                R.GunAction:FireServer("fire");
                                sRE:FireServer();
                            end; twait();
                        end;
                    end;
                end;
            elseif where == "City/Body" then
                local Bodies = GetChildren(W.Section1.DeadCivilians); for i=1, #Bodies do
                    local v = Bodies[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "HumanoidRootPart");
                        Prox = Prox and FindFirstChild(Prox, "ProximityPrompt");
                        if Prox then
                            Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                            fireproximityprompt(Prox);
                        end;
                    end;
                end; return Tp(HumRSelf, CFr(81, 9.3, 224));
            elseif where == "City/Mika" then
                Tp(HumRSelf, W.Section1.Monster.Trigger.CFrame);
            elseif where == "City/Hideo" then
                Tp(HumRSelf, GetPivot(W.Section1.HideoScene.Hideo2));
            elseif where == "City/Cutter" then
                local Prox = W.Section1.SchoolGatePart.Truck.BoltCutter.Main.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame); fireproximityprompt(Prox);
            elseif where == "City/Cut" then
                local Prox = W.Section1.SchoolGatePart.Gate.Chain.PromptPart.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame, 0.3); for i=1, 4 do
                    fireproximityprompt(Prox);
                end;
            elseif where == "School/Med" then
                fireproximityprompt(W.Section2.Items.Bandage.Handle.ProximityPrompt);
            elseif where == "School/Heal" then
                local sRE = R.modules.Packet.Reliable;
                sRE:FireServer("Section2/HideoMinigameStarted");
                sRE:FireServer("Section2/HideoHealed");
                return sRE:FireServer("Section2/HideoMinigameEnded");
            elseif where == "School/Note" then
                Tp(HumRSelf, CFr(142, 20, 504), 0.3);
                fireproximityprompt(W.Section2.MAINOBJECTIVE.Locker.LockerDoor.ProximityPart.ProximityPrompt);
                Tp(HumRSelf, CFr(142, 20, 504), 0.3);
                fireproximityprompt(W.Section2.MAINOBJECTIVE.Diary.ProximityPrompt, 0.3);
            elseif where == "School/Freeze" then
                local CHs = GetChildren(W.Section2.MAINOBJECTIVE2.Spiders); for i=1, #CHs do
                    local v=CHs[i]; if v.Name ~= "AkariSpider" then continue; end;
                    local RootPart = FindFirstChild(v, "RootPart");
                    if not RootPart then continue; end;

                    local Bones = FindFirstChild(RootPart, "Bone");
                    if not Bones then continue; end;
                    Bones:Destroy();
                end;
            elseif where == "School/Spider" then
                local CHs = GetChildren(W.Section2.MAINOBJECTIVE2.Spiders); for i=1, #CHs do
                    local v=CHs[i]; if v.Name ~= "AkariSpider" then continue; end;
                    local Hitbox = FindFirstChild(v, "Hitbox");
                    if not Hitbox then continue; end;
                    local sRE = FindFirstChild(Hitbox, "RemoteEvent");
                    if not sRE then continue; end;

                    local Akari = FindFirstChild(W.Section2.Monster, "AkariNM") or FindFirstChild(W.Section2.Monster, "Akari");
                    Akari = Akari or FindFirstChild(W.Section2.Rage, "AkariRageNM", true) or FindFirstChild(W.Section2.Rage, "AkariRage", true);
                    if not Akari or not Akari.Parent then return; end;
                    
                    if distOf(Akari.Hitbox, HumRSelf, 60) then continue; end;

                    Tp(HumRSelf, Hitbox.CFrame, 0.3);

                    for ri=1, 50 do
                        if not Hitbox.Parent or not sRE.Parent then
                            break;
                        end;

                        if distOf(Akari.Hitbox, HumRSelf, 60) then
                            Tp(HumRSelf, CFr(142, 20, 504)); break;
                        end;

                        if self:ToolNow("Gun") then
                            R.GunAction:FireServer("fire");
                            sRE:FireServer(); twait();
                        end;
                    end;
                end;
            elseif where == "School/Exit" then
                Tp(HumRSelf, CFr(175, 8, 508), 0.3);
                fireproximityprompt(W.Section2.School.Doors.ExitDoor.ProxPart.ProximityPrompt);
            elseif where == "School/Forest" then
                Tp(HumRSelf, CFr(-197, 50, 338));
            elseif where == "Forest/Cave" then
                Tp(HumRSelf, W.Section3.Trigger.CFrame, 1);
                Tp(HumRSelf, W.Section3.OBJECTIVE.Trigger2.CFrame);
            elseif where == "Forest/Generator" then
                local CHs = GetChildren(W.Section3.OBJECTIVE.Circuits); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "CircuitPillar" then
                        v.CollisionPart.CanCollide = false;
                        Tp(HumRSelf, v.CollisionPart.CFrame, 0.3);
                        fireproximityprompt(v.PromptPart.ProximityPrompt);
                        for i=1, 3 do
                            if GetAttribute(v, "CurrentRound") == 4 then
                                return;
                            end; R.modules.Packet.Reliable:FireServer(
                                "Section3/CircuitRoundComplete",
                                v
                            );
                        end;
                    end;
                end;
            elseif where == "IJO/Keycard" then
                local Prompt = W.Section4.Lab.Floor1.Entrance.IDCARD.ProximityPrompt;
                Tp(HumRSelf, Prompt.Parent.CFrame, 0.3); fireproximityprompt(Prompt);
            elseif where == "IJO/PASS" then
                R.modules.Packet.Unreliable:FireServer(
                    "Section4/LaptopSubmit",
                    W.Section4.Lab.Floor1.Objective.StickyNote.PASSWORD.SurfaceGui.RandomNumber.Text
                );
            elseif where == "IJO/C4" then
                local CHs=GetChildren(W.Section4.Lab.Floor1.Objective2.C4Explode); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "C4Bomb" then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(Prox, 1);
                    end;
                end;
            elseif where == "IJO/C4_2" then
                Tween({primary = HumRSelf; goal = { CFrame = CFr(-4147, 107, 2154) }, info=TweenInfo.new(3)});
                Tween({primary = HumRSelf; goal = { CFrame = CFr(-4143, 107, 2501) }, info=TweenInfo.new(3)});
                local CHs = GetChildren(W.Section4.Lab.Floor1.Objective3.C4Explode); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "C4Bomb" then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(Prox, 1);
                    end;
                end;
            elseif where == "IJO/Exit" then
                Tp(HumRSelf, CFr(-3379, -300, 4451));
            elseif where == "IJO/Terminal" then
                local HogoGuntai = FindFirstChild(W.Section4.Monster, "HogoGuntai");
                local CHs=GetChildren(W.Section4.Lab.CleanseRoomObjective.ShapeTerminals); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and strfind(v.Name, "Terminal") then
                        local Prox = FindFirstChild(v, "PromptPart");
                        Prox = Prox and FindFirstChild(Prox, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        if distOf(HogoGuntai.Hitbox, Prox.Parent, 60) then
                            continue;
                        end; Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                        fireproximityprompt(Prox); twait(0.3);
                        Tp(HumRSelf, CFr(-3389, -298, 4390), 1);
                        R.modules.Packet.Reliable:FireServer(
                            "ShapeTerminal/RoundComplete",
                            v
                        );
                        R.modules.Packet.Reliable:FireServer(
                            "ShapeTerminal/Release",
                            v
                        );
                    end;
                end; Tp(HumRSelf, CFr(-3389, -298, 4390));
            elseif where == "IJO/Valve" then
                local HogoGuntai = FindFirstChild(W.Section4.Monster, "HogoGuntai");
                local CHs=GetChildren(W.Section4.Lab.CleanseRoomObjective.Valves);
                
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                        local Icon = v.Notification.Icon;
                        if not Icon.Enabled then continue; end;
                        local Chs = GetChildren(v);
                        while Icon.Enabled do
                            Tp(HumRSelf, Icon.Parent.CFrame); for i=1, #Chs do
                                local v2 = Chs[i]; if v2 and v2.Name == "Turners" then
                                    local Prompt = FindFirstChild(v2, "Right");
                                    if distOf(HogoGuntai.Hitbox, Prompt.Parent, 60) then
                                        return Tp(HumRSelf, CFr(-3389, -298, 4390));
                                    elseif Prompt then
                                        Tp(HumRSelf, Icon.Parent.CFrame);
                                        fireproximityprompt(Prompt);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            elseif where == "IJO/Threat" then
                R.modules.Packet.Reliable:FireServer("Section4/LockdownSkillCheckHit");
            elseif where == "Water/Stair" then
                Tp(HumRSelf, W.Section5.StairsSection.EndTrigger.CFrame);
            elseif where == "Water/Main" then
                local MainSwitch = W.Section5.MainObjective.PowerSwitch.RootPart.ProximityPrompt;
                Tp(HumRSelf, MainSwitch.Parent.CFrame, 0.3);
                fireproximityprompt(MainSwitch, 1);
            elseif where == "Water/Wire" then
                local sRE = R.modules.Packet.Reliable;
                local CHs = GetChildren(W.Section5.MainObjective.Boxes);

                for i=1, #CHs do
                    local box=CHs[i]; if box.Parent and box.Name == "WireBox" then
                        if box.PromptPart.ProximityPrompt.Enabled then
                            sRE:FireServer("Section5/WireBoxClaim", box);
                            sRE:FireServer("Section5/WireBoxClaim", box);

                            for _,v in pairs(GetChildren(box.Bolt)) do
                                if v.Name == "Screw" then
                                    sRE:FireServer("Section5/WireBoxScrewDone", v);
                                end;
                            end; for _,v in pairs(GetChildren(box.Cuttable)) do
                                if v.Name == "Cut" then
                                    sRE:FireServer("Section5/WireBoxCutDone", v);
                                end;
                            end;

                            sRE:FireServer("Section5/WireBoxComplete", box);
                        end;
                    end;
                end;
            end;
        end;
        Functions.B3C1ESP = function(self, where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "City/Gatas" then
                local CHs=GetChildren(W.Section1.Grunts); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC10;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "City/Bodies" then
                local Bodies = GetChildren(W.Section1.DeadCivilians); for i=1, #Bodies do
                    local v = Bodies[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "HumanoidRootPart");
                        Prox = Prox and FindFirstChild(Prox, "ProximityPrompt");
                        local ESPObject = ESPF.ESP(where, v, {
                            Color = if Prox then YELLOW else GREEN;
                            Size = VEC10;
                            Text = v.Name;
                        }); if Prox and not ESPObject.PropChange then
                            ESPObject.PropChange = Prox.Destroying:Once(function()
                                ESPObject.UpdateColor(GREEN);
                            end);
                        end;
                    end;
                end;
            elseif where == "Akari" then
                local Akari = FindFirstChild(W.Section2.Monster, "AkariNM") or FindFirstChild(W.Section2.Monster, "Akari");
                Akari = Akari or FindFirstChild(W.Section2.Rage, "AkariRageNM", true) or FindFirstChild(W.Section2.Rage, "AkariRage", true);
                if not Akari then return; end; ESPF.ESP(where, Akari, {
                    Color = RED;
                    Size = VEC10;
                    Text = Akari.Name;
                });
            elseif where == "Mizuno" then
                local Mizuno = FindFirstChild(W.Section3.Monster, "Mizuno") or FindFirstChild(W.Section3.Monster, "MizunoNM");
                if not Mizuno then return; end; ESPF.ESP(where, Mizuno, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Mizuno";
                });
            elseif where == "Terminal" then
                local CHs=GetChildren(W.Section4.Lab.CleanseRoomObjective.ShapeTerminals); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.Name == "Terminal" then
                        ESPF.ESP(where, v, {
                            Color = WHITE;
                            Size = VEC10;
                            Text = "Terminal";
                        });
                    end;
                end;
            elseif where == "BoulderSeal" then
                ESPF.ESP(where, W.Section4.Lab.Floor1.Objective2.C4Explode.BoulderSeal, {
                    Color = GREEN;
                    Size = VEC10;
                    Text = "Seal";
                });
            elseif where == "HogoGuntai" then
                ESPF.ESP(where, W.Section4.Monster.HogoGuntai, {
                    Color = RED;
                    Size = VEC10;
                    Text = "HogoGuntai";
                });
            elseif where == "Baigai" then
                ESPF.ESP(where, W.Section5.Monster.Baigai, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Baigai";
                });
            end; ESPF.Visible(where, true, true);
        end;
        Functions.NMCSFunc = function(self, where, tbl)
            local REs = R.modules.Packet.Reliable;
            if where == "1/Darts" then
                local Cords = {
                    {-0.88143342681816828,  0.87117157036754522},
                    {-0.40142137418766055,  0.91716707364216832},
                    { 0.041346730334789528, 0.8769210384745052},
                    { 0.39722330242307746,  0.87692111900152425},
                    { 0.91447760427951508,  0.93441523638199131},
                    { 0.88964793123131491,  0.17548872773929206},
                    { 0.46343281770698325,  0.071998462868049354},
                    {-0.074516259216243566, 0.066249321902104238},
                    {-0.35176052119367995,  0.049001199425790821},
                    {-0.89798600124604222,  0.16398952981256001},
                    {-0.90212515911099733, -0.84791254881688827},
                    {-0.41797322414554394, -0.84791254881688827},
                    { 0.086870269239940817, -0.84791287092496448},
                    { 0.3848092483265671,  -0.84791279039794543},
                    { 0.85654341990915883, -0.8594110018686939},
                }; for i=1, #Cords do
                    local v=Cords[i]; REs:FireServer(
                        "Section1/DartsThrow",
                        v[1],
                        v[2]
                    ); twait(0.3);
                end;
            elseif where == "1/Ring" then
                local Cords = {
                    { 0.025000014497587892,  0.075852090323513199},
                    {-0.48124999568487214,   0.090211719613183625},
                    { 0.43541668060546079,   0.089783043685284517},
                    { 0.0083333444781597057, 0.4083325663073496},
                    {-0.35625002564241487,   0.43911111371761014},
                    { 0.45416664673636364,   0.39147921583869238},
                }; for i=1, #Cords do
                    local v=Cords[i]; REs:FireServer(
                        "Section1/RingThrow",
                        v[1],
                        v[2]
                    ); twait(1);
                end;
            elseif where == "1/Clowns" then
                for i=1, #tbl do
                    local v=tbl[i]; if v.Parent then
                        if GetAttribute(v, "Active") then
                            REs:FireServer("Section1/Whack", v);
                        end;
                    end;
                end; return;
            elseif where == "1/Hammer" then
                return REs:FireServer("Section1/HighStrikerClick");
            elseif where == "1/Dunk" then
                return REs:FireServer(
                    "Section1/DunkThrow",
                    0.27402551854143786,
                    -0.0085155691596274265
                );
            elseif where == "1/Basketball" then
                REs:FireServer(
                    "Section1/BasketballHold"
                ); twait(0.997) REs:FireServer(
                    "Section1/BasketballRelease",
                    0.997
                );
            elseif where == "1/Golf" then
                W.Section1.Games.MiniGolf.GolfBall.CFrame = W.Section1.Games.MiniGolf.Hole.CFrame;
            elseif where == "2/Moon" then
                local P3 = W.Section2.MainObjective.Puzzle3;
                if GetAttribute(P3, "Complete") then return; end;
                local Prox = P3.PromptPart.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                fireproximityprompt(Prox); for i=1, 8 do
                    REs:FireServer("Section2/MoonPuzzleProgress", i);
                end; REs:FireServer("Section2/MoonPuzzleComplete");
            elseif where == "2/Star" then
                local P4 = W.Section2.MainObjective.Puzzle1;
                if GetAttribute(P4, "Complete") then return; end;
                local Prox = P4.PromptPart.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                fireproximityprompt(Prox); for i=1, 5 do
                    REs:FireServer("Section2/StarPuzzleProgress", i);
                end; REs:FireServer("Section2/StarPuzzleComplete");
            elseif where == "2/Tarrot" then
                local P4 = W.Section2.MainObjective.Puzzle4;
                if GetAttribute(P4, "Complete") then return; end;
                local Prox = P4.PromptPart.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame, 0.3);
                fireproximityprompt(Prox); twait(0.3); for i=1, 5 do
                    REs:FireServer("Section2/TarotPuzzleProgress", i);
                end; REs:FireServer("Section2/TarotPuzzleComplete");
            elseif where == "2/Statue" then
                local CProx = self.EYEConduct;
                local Orders = self.Orders;
                local Eyes = self.Eyes;
                if not CProx or not CProx.Enabled then return; end;
                if #Orders ~= 0 then
                    for i=1,#Orders do
                        local v=Orders[i]; if v then
                            local Eye = Eyes[v]; if Eye then
                                Tp(HumRSelf, Eye.S.Part.CFrame, 0.3);
                                fireproximityprompt(Eye.S.Prompt.ProximityPrompt);
                            end;
                        end;
                    end; tble.clear(Orders); twait(2);
                end;
            elseif where == "3/Boss" then
                local Boss = W.Section3.DimitraBOSS.PlayerHitbox;
                Tp(HumRSelf, Boss.CFrame);
                REs:FireServer("MagicAxe/SwingHit");
            end;
        end;
        Functions.KenFunc = function(self, where)
            if where == "Lever" then
                local Base = W.Intro.Task.Lever.Base; CAMERAOBJECT = Base;
                Tp(HumRSelf, Base.CFrame, 0.3); tk.delay(0.5, function()
                    fireproximityprompt(Base.ProximityPrompt);
                end); Functions:CKey(VIM, Enum.KeyCode.E);
                CAMERAOBJECT = EMPTY_OBJECT;
            elseif where == "Note" then
                local Note = W.Note.Note; CAMERAOBJECT = Note;
                Tp(HumRSelf, Note.CFrame, 0.3); tk.delay(0.5, function()
                    fireproximityprompt(Note.ProximityPrompt);
                end); Functions:CKey(VIM, Enum.KeyCode.E);
                CAMERAOBJECT = EMPTY_OBJECT;
            elseif where == "TpLab" then
                Tp(HumRSelf, CFr(27, 3, 104));
            elseif where == "TpWire" then
                Tp(HumRSelf, CFr(105, 3, -133));
            elseif where == "TpExit" then
                Tp(HumRSelf, CFr(16, 3, -214));
            elseif where == "RealExit" then
                Tp(HumRSelf, CFr(340, 4, -513));
            end;
        end;
        Functions.JigokuFunc = function(self, where)
            if where == "AutoFind" then
                if Chapter == "Lobby" then
                    QueuePack.SetInfo("Jigoku", true);
                    QueuePack.Init();
                    R.LobbyInterface.Networking.Lobby:FireServer(
                        "SingleplayerTeleport",
                        {
                            Chapter = 1,
                            Mode = "Nightmare",
                            Book = "Control"
                        }
                    );
                elseif PlaceId == 6479231833 then
                    local IdleNPC = WaitForChild(W, "IdleNPC", 5 + math.clamp(self.GetPing(), 0, 100));
                    if not Config.Jigoku.AutoFind then return; end;
                    if not IdleNPC then
                        QueuePack.SetInfo("Jigoku", true);
                        QueuePack.Init();
                        TeleportService:Teleport(6243699076, selff);
                    end;

                    Tp(HumRSelf, WaitForChild(IdleNPC, "HumanoidRootPart").CFrame, 0.3);
                    fireproximityprompt(IdleNPC.HumanoidRootPart.PromptPoint.ProximityPrompt); twait(0.3 + math.clamp(self.GetPing(), 0, 100));
                    R.Dialog.Complete:FireServer();
                    R.Option.Vote:FireServer("3");
                end;
            elseif where == "Talk" then
                Tp(HumRSelf, CFr(607.54, 11.91, 1080));
            elseif where == "Complete" then
                local CHs = GetChildren(GameAI.Souls); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3);
                        fireproximityprompt(Prox);
                    end;
                end;
            end;
        end;
        Functions.JigokuESP = function(where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "Souls" then
                local CHs = GetChildren(GameAI.Souls); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        ESPF.ESP(where, v, {
                            Color = WHITE;
                            Size = VEC2;
                            Text = ".";
                        });
                    end;
                end;
            elseif where == "Shinigami" then
                local Shinigami = W.GameAI.AI.HumanoidRootPart;
                ESPF.ESP(where, Shinigami, {
                    Color = RED;
                    Size = VEC10;
                    Text = "Shinigami";
                });
            end; ESPF.Visible(where, true, true);
        end;
        Functions.EgaoFunc = function(where, count)
            if where == "AutoFind" then
                if Chapter == "Lobby" then
                    QueuePack.SetInfo("Egao", true);
                    QueuePack.Init();
                    R.LobbyInterface.Networking.Lobby:FireServer(
                        "SingleplayerTeleport",
                        {
                            Chapter = 1,
                            Mode = "Normal",
                            Book = "Rage"
                        }
                    );
                elseif Chapter == "B3C1" then
                    if count == nil then
                        local Intro = WaitForChild(W, "IntroCutscene", 9e9);
                        repeat twait(0.1); until not Intro or not Intro.Parent or not FindFirstChild(Intro, "SpawnBox");
                    end;

                    if Config.Egao.AutoFind then
                        if count == nil then
                            Tween({primary = HumRSelf; goal = { CFrame = CFr(-175, 7, -80) }; info=TweenInfo.new(3)});
                            Tween({primary = HumRSelf; goal = { CFrame = CFr(-175, 7, -21) }; info=TweenInfo.new(3)});
                        elseif count == 1 then
                            for i=1, 3 do
                                Tp(HumRSelf, CFr(-3652, 8, 295), 1);
                            end;

                            Tween({primary = HumRSelf; goal = { CFrame = CFr(-3658, 8, 372) }; info=TweenInfo.new(3)});
                        end; pcall(function() firetouchinterest(HumRSelf, W.EgaoSpawns.Part, 0); end);
                        local ISEGAO = false; PSG.EgaoPulseText.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
                            ISEGAO = true;
                        end); tk.delay(5 + math.clamp(Functions.GetPing(), 0, 100), function()
                            if not ISEGAO then
                                if count == nil then
                                    Functions.EgaoFunc("AutoFind", 1);
                                elseif count == 1 then
                                    QueuePack.SetInfo("Egao", true);
                                    QueuePack.Init();
                                    TeleportService:Teleport(6243699076, selff);
                                end;
                            else
                                WindUI:Notify({
                                    Title = "<font color='rgb(255,0,0)'>EGAO</font>",
                                    Content = "IS HERE!",
                                    Icon = "circle-alert",
                                    Duration = 5,
                                });
                            end;
                        end);
                    end;
                end;
            elseif where == "AutoLook" then
                local Egao = FindFirstChild(W, "EgaoEventRig");
                local Root = Egao and FindFirstChild(Egao, "RootPart");
                if not Root then return; end;
                local CamCF = Cam.CFrame
                Root.Position = CamCF.Position + CamCF.LookVector * 10;
            end;
        end;
        Functions.WitchTrialFunc = function(where)
            if where == "Complete" then
                local GameTPTWT = FindFirstChild(W, "Game Teleporter", true);
                if not GameTPTWT then return; end;
                ForceFloat = true;
                return Tp(HumRSelf, GameTPTWT.CFrame);
            elseif where == "Fire1" then
                return Tp(HumRSelf, CFr(2621.90186, 111.203804, 1453.71765));
            elseif where == "Fire2" then
                return Tp(HumRSelf, CFr(2426.72583, 185.146057, 1457.37292));
            elseif where == "Butterfly" then
                local CHs = GetChildren(GameAI); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local TWTPRompt = FindFirstChildWhichIsA(v, "ProximityPrompt", true);
                        if not TWTPRompt then return; end;
                        Tp(HumRSelf, TWTPRompt.Parent.CFrame + (TWTPRompt.Parent.CFrame.LookVector * -9), 0.3);
                        fireproximityprompt(TWTPRompt);
                    end;
                end;
            end;
        end;
        Functions.WitchTrialESP = function(where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "Monsters" then
                local CHs = if not GameAI then GetChildren(W) else GetChildren(GameAI);
                
                for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        if v.ClassName == "Model" and (strfind(v.Name, "AI") or v.Parent == GameAI) then
                            local AI = FindFirstChild(v, "AI");
                            if not AI then continue; end;
                            ESPF.ESP(where, v, {
                                Color = RED;
                                Size = VEC10;
                                Text = v.Name;
                            });
                        end;
                    end;
                end;
            end; ESPF.Visible(where, true, true);
        end;
        Functions.HalloweenTrialFunc = function(self, where)
            if where == "Candy" then
                local CHs = GetChildren(W.Candy); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Parent then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end;
            elseif PlaceId == 7633631103 then
                local CHs = GetChildren(W.GameInfo.PuzzleItems); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end;

                local Prox = W.Map.Well.Burner.ProximityPrompt;
                Tp(HumRSelf, Prox.Parent.CFrame, 0.3);

                for i=1, 3 do
                    fireproximityprompt(Prox);
                end;
            elseif PlaceId == 7633631351 then
                local CHs = GetChildren(W.Candles); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent and v.ClassName == "Model" then
                        local Candles = FindFirstChild(v, "Candles");
                        local Prox = Candles and FindFirstChild(Candles, "ProximityPrompt");
                        if not Prox or not Prox.Enabled then continue; end;
                        Tp(HumRSelf, Candles.CFrame, 0.3); fireproximityprompt(Prox);
                    end;
                end; Tp(HumRSelf, CFr(395, 206, -98));
            elseif where == "Potion" then
                local CProx = W.MainObjective.Cauldron.Main.ProximityPrompt;

                local Collection = nil; R.StateInfo.OnClientEvent:Once(function(Type, data)
                    if Type ~= "Collection" then return; end;
                    Collection = data;
                end);
                
                Tp(HumRSelf, CProx.Parent.CFrame, 0.3); fireproximityprompt(CProx);
                twait(0.2 + math.clamp(self.GetPing(), 0, 100));

                local state, Need = {
                    Roses = 0;
                    Eyes = 0;
                    Bats = 0;
                    Snakes = 0;
                }, {
                    Roses = 3;
                    Eyes = 2;
                    Bats = 2;
                    Snakes = 1;
                }; for i=1, #Collection do
                    state[Collection[i]] += 1;
                end;

                local MHs = GetChildren(W.MainObjective.Ingredients); for i=1, #MHs do
                    local Folder=MHs[i]; if Folder then
                        if state[Folder.Name] < Need[Folder.Name] then
                            local CHs = GetChildren(Folder); for i2=1, #CHs do
                                if state[Folder.Name] == Need[Folder.Name] then
                                    break;
                                end;

                                local v=CHs[i2]; if v.Parent then
                                    if v.Name ~= "Bat" then
                                        local Prox = FindFirstChild(v, "ProximityPrompt");
                                        if not Prox or not Prox.Enabled then continue; end;
                                        Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);

                                        state[Folder.Name] += 1;
                                    elseif FindFirstChild(v, "Torso") then
                                        local Prox = FindFirstChild(v.Torso, "ProximityPrompt");
                                        if not Prox or not Prox.Enabled then continue; end;
                                        Tp(HumRSelf, Prox.Parent.CFrame, 0.3); fireproximityprompt(Prox);

                                        state[Folder.Name] += 1;
                                    end;
                                end;    
                            end;
                        end;
                    end;
                end;
                
                Tp(HumRSelf, CProx.Parent.CFrame, 0.3); fireproximityprompt(CProx);
            end;
        end;
        Functions.HalloweenTrialESP = function(where, state)
            if not state then
                return ESPF.Visible(where, false);
            elseif where == "Monster" then
                local CHs = GetChildren(W.GameAI); 
                for i=1, #CHs do
                    local v = CHs[i]; if v.Parent then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC10;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "AI" then
                local CHs = GetChildren(W.AI); 
                for i=1, #CHs do
                    local v = CHs[i]; if v.Parent and v.ClassName == "Model" then
                        ESPF.ESP(where, v, {
                            Color = RED;
                            Size = VEC10;
                            Text = v.Name;
                        });
                    end;
                end;
            elseif where == "Candy" then
                local CHs = GetChildren(W.Candy); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChild(v, "ProximityPrompt");
                        if not Prox or not Prox.Parent then continue; end;
                        ESPF.ESP(where, Prox.Parent, {
                            Color = GREEN;
                            Size = VEC2;
                            Text = v.Name;
                        });
                    end;
                end;
            end; ESPF.Visible(where, true, true);
        end;

        ScriptData.AutoData = (IB_NO_VIRTUALIZE(function() return {
            ClientTab = {
                {type="Group", dats={
                    {dat={
                        {type="Toggle", EN="Auto Free Yourself", EN2="Automatically press E when needed.", TH1="ปลดปล่อยตัวเองอัตโนมัติ", TH2="ออโต้กดEเมื่อจำเป็น", Bindable="+", Path="Client/AutoFreeYourself"},
                        {type="Toggle", EN="Instant Prompt", EN2="Instantly activate prompts.", TH1="กดปุ่มทันที", TH2="กดปุ่มได้แบบทันที", Bindable="+", Path="Client/InstantPrompt"},
                        {type="Toggle", EN="No Render", EN2="Change camera subject & disable 3D rendering", TH1="ปิดการ Render", TH2="เปลี่ยนกล้องและปิดการ render 3D", Bindable="+", Path="Client/No Render", Callback=function(state)
                            ClientCon["No Render"] = state;
                            H:Set3dRenderingEnabled(not state);
                            Cam.CameraSubject = if state then VOIDPART else HumSelf;
                        end},
                        {type="Toggle", EN="Full Bright", EN2="Make the game brighter, easier to see or look around.", TH1="แมพสว่าง", TH2="มองเห็นง่ายขึ้น", Bindable="+", Path="Client/Full Bright"},
                        {type="Toggle", EN="Float", EN2="Make your character float in the air.", TH1="ลอย", TH2="ทำให้ตัวละครเดินบนอากาศได้", Bindable="+", Path="Client/Float"},
                        {type="Toggle", EN="Noclip", EN2="Allow you to walk through walls.", TH1="เดินทะลุกำแพง", TH2="ต้องอธิบายด้วยหรอ", Bindable="+", Path="Client/Noclip"},
                        {type="Slider", EN="Walk Speed", EN2="Change the speed of your walk.", TH1="ความเร็วในการเดิน", TH2="ปรับความเร็วการเดิน", Value={Min=1, Max=100}, Path="Client/WalkSpeed", Callback=function(value)
                            ClientCon.WalkSpeed = value;
                            ClientPackage.SetWalkSpeed(value)
                        end},
                        {type="Toggle", EN="Enable Walk Speed", EN2="Enable walk speed modification.", TH1="เปิดใช้งานความเร็วในการเดิน", TH2="ปรับความเร็วในการเดิน", Bindable="+", Path="Client/Enable WalkSpeed", Locked=Chapter=="B3C1", Callback=function(state)
                            ClientCon["Enable WalkSpeed"] = state;
                            ClientPackage.RunWalkSpeed(state);
                        end},
                        {type="Slider", EN="Teleport Walk Speed", EN2="Change the speed of teleport walk.", TH1="ความเร็วในการเดินแบบวาร์ป", TH2="ปรับความเร็วในการเดินแบบวาร์ป", Value={Min=1, Max=10}, Path="Client/TeleportWalk Speed"},
                        {type="Toggle", EN="Enable Teleport Walk", EN2="Enable teleport walk.", TH1="เปิดใช้งานเดินแบบวาร์ป", TH2="เปิดใช้งานเดินโดยการวาร์ปไปเรื่อยๆ", Bindable="+", Path="Client/Enable TeleportWalk"},
                        {type="Slider", EN="Jump Power", EN2="Change the power of your jump.", TH1="ความแรงในการกระโดด", TH2="ปรับความแรงในการกระโดด", Value={Min=1, Max=300}, Path="Client/JumpPower"},
                        {type="Toggle", EN="Enable Jump Power", EN2="Enable jump power modification.", TH1="เปิดใช้งานความแรงในการกระโดด", TH2="ปรับความแรงในการกระโดด", Bindable="+", Path="Client/Enable JumpPower"},
                    }, Title="Client", Open=true};
                }};
            };
            PlaceholderTab = (Chapter == "Lobby" and {
                {type="Paragraph", Title="Information", Desc="The Mimic script is now Internal Base which make it smoother and safer to use. To unlock other tab like Control I or Rage I, you must join the main game first. There are a few settings in Core Settings that you can use for The Mimic."},
            });
            PackNMCS = (Chapter == "NMCS" and {
                Tabs={
                    {Tab={at="NMCS", Title="Clown", Icon="skull", Path="NMCS"}, Data={
                        {type="Button", EN="Auto Darts", EN2="Auto complete darts puzzle.", TH1="ออโต้เกมปาลูกดอก", TH2="ทำเควสปาลูกดอกให้เสร็จ", Callback=function()
                            return Functions:NMCSFunc("1/Darts");
                        end};
                        {type="Button", EN="Auto Ring", EN2="You must enter the minigame first.", TH1="ออโต้เกมโยนห่วง", TH2="คุณต้องเข้าไปในมินิเกมก่อน", Callback=function()
                            return Functions:NMCSFunc("1/Ring");
                        end};
                        {type="Button", EN="Auto Dunk", EN2="You must enter the minigame first.", TH1="ออโต้เกมโยนห่วง", TH2="คุณต้องเข้าไปในมินิเกมก่อน", Callback=function()
                            return Functions:NMCSFunc("1/Dunk");
                        end};
                        {type="Button", EN="Auto Basketball", EN2="You must enter the minigame first.", TH1="ออโต้เกมบาสเกตบอล", TH2="คุณต้องเข้าไปในมินิเกมก่อน", Callback=function()
                            return Functions:NMCSFunc("1/Basketball");
                        end};
                        {type="Button", EN="Auto Golf", EN2="You must enter the minigame first.", TH1="ออโต้เกมกอล์ฟ", TH2="คุณต้องเข้าไปในมินิเกมก่อน", Callback=function()
                            return Functions:NMCSFunc("1/Golf");
                        end};
                        {type="Toggle", EN="Auto Clowns", EN2="Auto complete clown puzzle. This will only work while in the minigame.", TH1="ออโต้ทุบหัวตัวตลก", TH2="ทำเควสทุบหัวตัวตลกให้เสร็จ เมื่ออยู่ในมินิเกม", Bindable="+", Path="AutoClowns"};
                        {type="Toggle", EN="Auto Hammer", EN2="Auto complete hammer puzzle. This will only work while in the minigame.", TH1="ออโต้ค้อน", TH2="ทำเควสค้อนให้เสร็จ เมื่ออยู่ในมินิเกม", Bindable="+", Path="AutoHammer"};
                    }};
                    {Tab={at="NMCS", Title="Dimitra", Icon="skull", Path="NMCS"}, Data={
                        {type="Button", EN="Auto Moon Puzzle", EN2="Teleport & complete moon puzzle. You have to atleast enter the game once.", TH1="ออโต้พระจันทร์", TH2="วาปแล้วทำเควสให้เสร็จ โดยจะต้องเข้ามินิเกมเองอย่างน้อย1ครั้ง", Callback=function()
                            return Functions:NMCSFunc("2/Moon");
                        end};
                        {type="Button", EN="Auto Star Puzzle", EN2="Teleport & complete star puzzle. You have to atleast enter the game once.", TH1="ออโต้ดวงดาว", TH2="วาปแล้วทำเควสให้เสร็จ โดยจะต้องเข้ามินิเกมเองอย่างน้อย1ครั้ง", Callback=function()
                            return Functions:NMCSFunc("2/Star");
                        end};
                        {type="Button", EN="Auto Tarrot Puzzle", EN2="Teleport & complete tarrot puzzle. You have to atleast enter the game once..", TH1="ออโต้ไพ่", TH2="วาปแล้วทำเควสให้เสร็จ โดยจะต้องเข้ามินิเกมเองอย่างน้อย1ครั้ง", Callback=function()
                            return Functions:NMCSFunc("2/Tarrot");
                        end};
                        {type="Toggle", EN="Auto Statues", EN2="Teleport & complete statue puzzle. You have to atleast click all of the statue once. You also have to start the game or fail the game while this is running.", TH1="ออโต้รูปปั้น", TH2="วาปแล้วทำเควสให้เสร็จ โดยจะต้องกดรูปปั้นทุกอันอย่างน้อย1ครั้ง วิธีใช้คือต้องเปิดอันนี้ทิ้งไว้ก่อนเริ่มหรือต้องพลาดในมินิเกมก่อน", Bindable="+", Path="AutoStatue", Callback=function(state)
                            NMCSCon.AutoStatue = state; if not state or Functions.EYEConduct then return; end;
                            local Statues = W.Section2.MainObjective.Puzzle2.EyeStatues;
                            local Mirrors = W.Section2.MainObjective.Puzzle2.Mirrors;
                            local Eyes = nil;
                            
                            if GetAttribute(W, "MimicEvent") == "TheHollow" then
                                Eyes = {
                                    [1] = {
                                        S = Statues.Eye1;
                                        M = Mirrors.Mirror4.Eye.Part;
                                    };
                                    [2] = {
                                        S = Statues.Eye2;
                                        M = Mirrors.Mirror3.Eye.Part;
                                    };
                                    [3] = {
                                        S = Statues.Eye3;
                                        M = Mirrors.Mirror2.Eye.Part;
                                    };
                                    [4] = {
                                        S = Statues.Eye4;
                                        M = Mirrors.Mirror1.Eye.Part;
                                    };
                                };
                            else
                                Eyes = {
                                    [1] = {
                                        S = Statues.Eye4;
                                        M = Mirrors.Mirror4.Eye.Part;
                                    };
                                    [2] = {
                                        S = Statues.Eye3;
                                        M = Mirrors.Mirror3.Eye.Part;
                                    };
                                    [3] = {
                                        S = Statues.Eye2;
                                        M = Mirrors.Mirror2.Eye.Part;
                                    };
                                    [4] = {
                                        S = Statues.Eye1;
                                        M = Mirrors.Mirror1.Eye.Part;
                                    };
                                };
                            end;

                            local Orders = {}; for i=1, 4 do
                                local v=Eyes[i]; if v then
                                    PropChangeSignal(v.M, "Transparency"):Connect(function()
                                        if v.M.Transparency ~= 1 then
                                            if not tblef(Orders, i) then
                                                tblein(Orders, i);
                                            end;
                                        end;
                                    end);
                                end;
                            end;

                            Functions.Orders = Orders;
                            Functions.Eyes = Eyes;
                            Functions.EYEConduct = W.Section2.MainObjective.Puzzle2.EyeStatues.Eye1.Prompt.ProximityPrompt;
                        end}; {type="Space"};
                        {type="Toggle", EN="Auto Kill Dimitra", EN2="Teleport & kill Dimitra", TH1="ออโต้ฆ่า", TH2="วาปไปฆ่า Dimitra", Bindable="+", Path="AutoBoss"};
                    }};
                };
            });
            PackKen = (Chapter == "Ken" and {
                Tabs={
                    {Tab={at="Ken", Title="Main", Icon="skull", Path="Ken"}, Data={
                        {type="Button", EN="Pull Lever", EN2="Teleport & pull lever.", TH1="ดึงคันโยก", TH2="วาปและดึงคันโยก", Callback=function()
                            Functions:KenFunc("Lever");
                        end};
                        {type="Button", EN="Read Note", EN2="Teleport & read note.", TH1="อ่านโน๊ต", TH2="วาปและอ่านโน๊ต", Callback=function()
                            Functions:KenFunc("Note");
                        end};
                        {type="Button", EN="Teleport To Lab", EN2="Teleport to the lab room because you don't need fuse.", TH1="วาปไปที่แล็บ", TH2="วาปไปที่ห้องแล็บ เพราะไม่จำเป็นต้องใช้ฟิว", Callback=function()
                            Functions:KenFunc("TpLab");
                        end};
                        {type="Button", EN="Teleport To Wire", EN2="Teleport to the objective wire room.", TH1="วาปไปที่ห้อง", TH2="วาปไปที่ห้องต่อสายไฟ", Callback=function()
                            Functions:KenFunc("TpWire");
                        end};
                        {type="Button", EN="Teleport To Exit Door", EN2="Teleport to the exit door room.", TH1="วาปไปที่ประตู", TH2="วาปไปที่ประตูทางออก", Callback=function()
                            Functions:KenFunc("TpExit");
                        end}; {type="Space"};
                        {type="Button", EN="Teleport To White Door", EN2="Teleport to the real exit door.", TH1="วาปไปที่ประตูสีขาว", TH2="วาปไปที่ประตูทางออกสีขาว", Callback=function()
                            Functions:KenFunc("RealExit");
                        end};
                    }};
                };
            });
            PackJigoku = (Chapter == "Lobby" and {
                Tabs={
                    {Tab={at="Jigoku", Title="Jigoku", Icon="skull", Path="Jigoku"}, Data={
                        {type="Toggle", EN="Auto Find Hell Place", EN2="Start & rejoin the game to find hell for you.", TH1="ออโต้หาด่าน", TH2="ออโต้กดเริ่มเกมและออกเกมเพื่อหาด่านนรก", Path="AutoFind", Callback=function(state)
                            Config.Jigoku.AutoFind = state;
                            Functions:JigokuFunc("AutoFind");
                        end};
                    }};
                };
            }) or (Chapter == "Jigoku" and {
                Tabs={
                    {Tab={at="Jigoku", Title="Main", Icon="skull", Path="Jigoku"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Talk & collect all souls with a perfect timer so you don't die", TH1="ออโต้จบเกม", TH2="วาปไปคุยกับ Shinigami แล้วเก็บดวงซิญญานทั้งหมดโดยมีการจับเวลาเพื่อใม่ให้ตาย", Callback=function(state)
                            Functions:JigokuFunc("Talk"); twait(11); Functions:JigokuFunc("Complete");
                        end};
                    }};
                    {Tab={at="Jigoku", Title="ESP", Icon="skull", Path="Jigoku"}, Data={
                        {type="Toggle", EN="Souls", EN2="Show soul's box", TH1="ESP ดวงวิญญาน", TH2="มองเห็นดวงวิญญาน", Path="ESP/Souls", Callback=function(state)
                            Config.Jigoku.ESP.Souls = state;
                            Functions.JigokuESP("Souls", state);
                        end};
                        {type="Toggle", EN="Shinigami", EN2="Show Shinigami's hitbox", TH1="ESP Shinigami", TH2="มองเห็น Shinigami", Path="ESP/Shinigami", Callback=function(state)
                            Config.Jigoku.ESP.Shinigami = state;
                            Functions.JigokuESP("Shinigami", state);
                        end};
                    }};
                    {Tab={at="Jigoku", Title="Sections", Icon="skull", Path="Jigoku"}, Data={
                        {type="Button", EN="Talk", EN2="Teleport & talk to Shinigami.", TH1="คุย", TH2="วาปไปคุยกับ Shinigami", Callback=function(state)
                            Functions:JigokuFunc("Talk");
                        end};
                        {type="Button", EN="Complete", EN2="Teleport & collect all souls.", TH1="จบเกม", TH2="วาปเก็บดวงวิญญานทั้งหมด", Callback=function(state)
                            Functions:JigokuFunc("Complete");
                        end};
                    }};
                };
            });
            PackEgao = (Chapter == "Lobby" and {
                Tabs={
                    {Tab={at="Egao", Title="Egao", Icon="smile", Path="Egao"}, Data={
                        {type="Toggle", EN="Auto Find Egao", EN2="Start & rejoin the game to find egao for you.", TH1="ออโต้หาด่าน", TH2="ออโต้กดเริ่มเกมและออกเกมเพื่อหา Egao", Path="AutoFind", Callback=function(state)
                            Config.Egao.AutoFind = state;
                            Functions.EgaoFunc("AutoFind");
                        end};
                        {type="Toggle", EN="Auto Look", EN2="Look at the Egao for you.", TH1="ออโต้มอง", TH2="ออโต้มอง Egao", Path="AutoLook"};
                    }};
                };
            }) or (Chapter == "B3C1" and {
                Tabs={
                    {Tab={at="Egao", Title="Egao", Icon="smile", Path="Egao"}, Data={
                        {type="Toggle", EN="Auto Look", EN2="Look at the Egao for you.", TH1="ออโต้มอง", TH2="ออโต้มอง Egao", Path="AutoLook"};
                    }};
                };
            });
            YenTab = ((strfind(Chapter, "B2") or strfind(Chapter, "B3")) and {
                {type="Toggle", EN="Collect All Yen", EN2="Teleport & collect spawned yen", TH1="เก็บเงินทั้งหมด", TH2="วาปไปเก็บเงินทั้งหมดที่เกิดอยู่", Path="Auto"},
                {type="Toggle", EN="Yen Aura", EN2="Auto collect nearby Yen.", TH1="ออโต้เก็บเงิน", TH2="ออโต้เก็บเงินในระยะ", Path="Aura"},
                {type="Toggle", EN="ESP Yen", EN2="Show Yen boxes.", TH1="ESP เงิน", TH2="มองเห็นเงิน", Path="ESP"},
            });
            PackB1C1 = (Chapter == "B1C1" and {
                Tabs={
                    {Tab={at="B1C1", Title="Main", Icon="book-open", Path="B1C1"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1}; {type="Space"},
                        {type="Toggle", EN="ESP Items", EN2="Show item's box & name", Path="ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                    }};
                };
            });
            PackB1C2 = (Chapter == "B1C2" and {
                Tabs={
                    {Tab={at="B1C2", Title="Main", Icon="book-open", Path="B1C2"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1}; {type="Space"},
                        {type="Toggle", EN="ESP Items", EN2="Show item's box & name", Path="ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                    }};
                };
            });
            PackB1C3 = (Chapter == "B1C3" and {
                Tabs={
                    {Tab={at="B1C3", Title="Main", Icon="book-open", Path="B1C3"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1}; {type="Space"},
                        {type="Toggle", EN="ESP Items", EN2="Show item's box & name", Path="ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                    }};
                };
            });
            PackB1C4 = (Chapter == "B1C4" and {
                Tabs= ((PlaceId == 7251865082 or PlaceId == 7265396387) and {
                    {Tab={at="B1C4", Title="Map 1", Icon="book-open", Path="B1C4"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="Map1/ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                        {type="Toggle", EN="ESP Items", EN2="Show item's box & name", Path="Map1/ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                    }};
                }) or ((PlaceId == 7251866503 or PlaceId == 7265396805) and {
                    {Tab={at="B1C4", Title="Map 2", Icon="book-open", Path="B1C4"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="Map2/ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                        {type="Toggle", EN="ESP Butterflies", EN2="Show item's box & name", Path="Map2/ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                    }};
                }) or ((PlaceId == 7251867155 or PlaceId == 7265397072) and {
                    {Tab={at="B1C4", Title="Map 3", Icon="book-open", Path="B1C4"}, Data={
                        {type="Button", EN="Auto Complete Game", EN2="Teleport to the end of the game.", TH1="ออโต้จบเกม", TH2="วาปไปที่ด่านสุดท้ายของเกม", Callback=Functions.AutoCompleteBook1};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="Map3/ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                        {type="Toggle", EN="ESP Items", EN2="Show item's box & name", Path="Map3/ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1};
                    }};
                }) or ((PlaceId == 7251867574 or PlaceId == 7265397848) and {
                    {Tab={at="B1C4", Title="Map 4", Icon="book-open", Path="B1C4"}, Data={
                        {type="Toggle", EN="Auto Kill Sama", EN2="Automatically destroy hearts.", TH1="ออโต้ทำลายหัวใจ", TH2="ทำลายหัวใจผี", Path="Map4/AutoKillSama"};
                        {type="Toggle", EN="Auto Kill Saigomo", EN2="Automatically kill saigomo.", TH1="ออโต้ฆ่า Saigomo", TH2="ออโต้ฆ่าผี", Path="Map4/AutoKillSaigomo"};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="Map4/ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=Functions.ESPMonsterBook1};
                        {type="Toggle", EN="ESP Hearts", EN2="Show item's box & name", Path="Map4/ESP/Items", TH1="ESP ไอเทม", TH2="มองเห็นไอเทม", Callback=Functions.ESPItemsBook1}; {type="Space"};
                    }};
                });
            });
            PackB2C1 = (Chapter == "B2C1" and {
                Tabs={
                    {Tab={at="B2C1", Title="City", Icon="book-open", Path="B2C1"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to Senzai.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปหา Senzai", Callback=function()
                            Functions:B2C1Func("City/Complete");
                        end}; {type="Space"},
                        {type="Toggle", EN="ESP Key", EN2="Show key's box & name", TH1="ESP กุญแจ", TH2="มองเห็นกุญแจ", Path="City/ESP/Key", Callback=function(state)
                            B2C1Con.City.ESP.Key = state;
                            Functions:B2C1ESP("City/Key", state);
                        end},
                    }};
                    {Tab={at="B2C1", Title="Rat", Icon="book-open", Path="B2C1"}, Data={
                        {type="Button", EN="Read Book", EN2="Teleport & read the book.", TH1="อ่านหนังสือ", TH2="วาปไปอ่านหนังสือ", Callback=function()
                            Functions:B2C1Func("Rat/Book");
                        end};
                        {type="Button", EN="Auto Rat", EN2="Teleport to collect rats & ring the bell.", TH1="ออโต้หนู", TH2="วาปไปเก็บหนูแล้วสั่นระฆัง", Callback=function()
                            Functions:B2C1Func("Rat/Rat");
                        end};
                        {type="Button", EN="Exit", EN2="Teleport & exit.", TH1="ออก", TH2="วาปไปกดออก", Callback=function()
                            Functions:B2C1Func("Rat/Exit");
                        end};
                        {type="Button", EN="Run", EN2="Tween to the exit in chase sequence.", TH1="วิ่ง", TH2="ค่อยๆบินไปที่ทางออกในด่านวิ่งหนู", Callback=function()
                            Functions:B2C1Func("Rat/Run");
                        end}; {type="Space"},
                        {type="Toggle", EN="ESP Book", EN2="Show book's box & name", TH1="ESP หนังสือ", TH2="มองเห็นหนังสือ", Path="Rat/ESP/Book", Callback=function(state)
                            B2C1Con.Rat.ESP.Book = state;
                            Functions:B2C1ESP("Rat/Book", state);
                        end};
                        {type="Toggle", EN="ESP Futakuchi", EN2="Show Futakuchi's box & name", TH1="ESP Futakuchi", TH2="มองเห็น Futakuchi", Path="Rat/ESP/Futakuchi", Callback=function(state)
                            B2C1Con.Rat.ESP.Futakuchi = state;
                            Functions:B2C1ESP("Rat/Futakuchi", state);
                        end};
                        {type="Toggle", EN="ESP Rat", EN2="Show rats' box & name", TH1="ESP หนู", TH2="มองเห็นหนู", Path="Rat/ESP/Rat", Callback=function(state)
                            B2C1Con.Rat.ESP.Rat = state;
                            Functions:B2C1ESP("Rat/Rat", state);
                        end};
                    }};
                    {Tab={at="B2C1", Title="Nagisa", Icon="book-open", Path="B2C1"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the cave entrance.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปทางเข้าถ้ำ", Callback=function()
                            Functions:B2C1Func("Nagisa/Auto");
                        end};
                        {type="Button", EN="Auto Run", EN2="Tween to the cave exit in the chase sequence.", TH1="ออโต้วิ่ง", TH2="ค่อยๆบินไปที่ทางออกในด่านวิ่ง", Callback=function()
                            Functions:B2C1Func("Nagisa/Run");
                        end},
                    }};
                    {Tab={at="B2C1", Title="Village", Icon="book-open", Path="B2C1"}, Data={
                        {type="Button", EN="Teleport To Main Village", EN2="Tween to the main village. <font color='rgb(255,0,0)'>[1]</font>", TH1="วาปเข้าหมู่บ้าน", TH2="ค่อยๆบินไปที่หมู่บ้านหลัก <font color='rgb(255,0,0)'>[1]</font>", Callback=function()
                            Functions:B2C1Func("Vil/Zone");
                        end};
                        {type="Button", EN="Talk", EN2="Talk to the npc. <font color='rgb(255,0,0)'>[2]</font>", TH1="คุย", TH2="วาปไปหา NPC <font color='rgb(255,0,0)'>[2]</font>", Callback=function()
                            Functions:B2C1Func("Vil/Talk");
                        end};
                        {type="Button", EN="Get Key", EN2="Teleport & grab the key. <font color='rgb(255,0,0)'>[3]</font>", TH1="เก็บกุญแจ", TH2="วาปไปเก็บกุญแจ <font color='rgb(255,0,0)'>[3]</font>", Callback=function()
                            Functions:B2C1Func("Vil/Key");
                        end}; {type="Space"},

                        {type="Button", EN="Paint", EN2="Teleport to the house. <font color='rgb(255,0,0)'>[4]</font>", TH1="วาด", TH2="วาปไปที่จุดวาด <font color='rgb(255,0,0)'>[3]</font>", Callback=function()
                            Functions:B2C1Func("Vil/PaintTp");
                        end};
                        {type="Button", EN="Auto Paint", EN2="Paint for you. <font color='rgb(255,0,0)'>[5]</font>", TH1="ออโต้วาด", TH2="วาดให้ <font color='rgb(255,0,0)'>[3]</font>", Locked=true, Callback=function()
                            Functions:B2C1Func("Vil/Paint");
                        end}; {type="Space"},
                        
                        {type="Button", EN="Get Pictures", EN2="Intilize model <font color='rgb(255,0,0)'>[6]</font>", TH1="เก็บข้อมูลรูปภาพ", TH2="ตั้งค่าโมเดลเกม <font color='rgb(255,0,0)'>[6]</font>", Callback=function()
                            Functions:B2C1Func("Vil/Pics");
                        end};
                        {type="Button", EN="Enter House", EN2="Teleport to the main house. <font color='rgb(255,0,0)'>[7]</font>", TH1="เข้าบ้าน", TH2="วาปไปบ้านหลัก <font color='rgb(255,0,0)'>[7]</font>", Callback=function()
                            Functions:B2C1Func("Vil/House");
                        end};
                        {type="Button", EN="Auto Candles", EN2="Teleport & light the candle for you. <font color='rgb(255,0,0)'>[8]</font>", TH1="เทียน", TH2="วาปไปจุดเทียน <font color='rgb(255,0,0)'>[8]</font>", Callback=function()
                            Functions:B2C1Func("Vil/Candle");
                        end}; {type="Space"},

                        {type="Toggle", EN="ESP Kurobozu", EN2="Show box & name", TH1="ESP Kurobozu", TH2="มองเห็น Kurobozu", Path="Vil/ESP/Kurobozu", Callback=function(state)
                            B2C1Con.Village.ESP.Kurobozu = state;
                            Functions:B2C1ESP("Vil/Kurobozu", state);
                        end};
                        {type="Toggle", EN="ESP Ohaguro", EN2="Show box & name", TH1="ESP Ohaguro", TH2="มองเห็น Ohaguro", Path="Vil/ESP/Ohaguro", Callback=function(state)
                            B2C1Con.Village.ESP.Ohaguro = state;
                            Functions:B2C1ESP("Vil/Ohaguro", state);
                        end};
                    }};
                    {Tab={at="B2C1", Title="Ship", Icon="book-open", Path="B2C1"}, Data={
                        {type="Button", EN="Enter Ship", EN2="Teleport to the trigger.", TH1="เข้าเรือ", TH2="วาปไปที่ทางเข้าเรือ", Callback=function()
                            Functions:B2C1Func("Ship/Enter");
                        end};
                        {type="Button", EN="Auto Candle", EN2="Teleport & light the candle.", TH1="ออโต้เทียน", TH2="วาปและจุดเทียน", Callback=function()
                            Functions:B2C1Func("Ship/Candle");
                        end};
                        {type="Button", EN="Auto Run", EN2="Tween to the exit in the chase sequence.", TH1="ออโต้วิ่ง", TH2="ค่อยๆบินไปที่ทางออกในด่านวิ่ง", Callback=function()
                            Functions:B2C1Func("Ship/Run");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Monsters", EN2="Show box & name", TH1="ESP ผี", TH2="มองเห็นผี", Path="Ship/ESP/Monsters", Callback=function(state)
                            B2C1Con.Ship.ESP.Monsters = state;
                            Functions:B2C1ESP("Ship/Monsters", state);
                        end};
                    }};
                };
            });
            PackB2C2 = (Chapter == "B2C2" and {
                Tabs={
                    {Tab={at="B2C2", Title="Statue", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Tween to the gate and wait 30 seconds.", TH1="ออโต้ผ่านด่าน", TH2="บินไปที่ประตูแล้วรอประมาณ 30 วินาที", Callback=function()
                            Functions:B2C2Func("Statue");
                        end};
                    }};
                    {Tab={at="B2C2", Title="Crounch", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Tween to the door and wait around 70 seconds.", TH1="ออโต้ผ่านด่าน", TH2="บินไปที่ประตูแล้วรอประมาณ 70 วินาที", Callback=function()
                            Functions:B2C2Func("Crounch");
                        end};
                    }};
                    {Tab={at="B2C2", Title="Meat", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Talk", EN2="Teleport to the NPC but does not talk for you due to anti cheat.", TH1="คุย", TH2="วาปไปหา NPC แต่จะไม่คุยให้เรื่องจากกันโปร", Callback=function()
                            Functions:B2C2Func("Meat/Talk");
                        end};
                        {type="Button", EN="Teleport To Meat", EN2="Teleport the meat but does not collect for you.", TH1="วาปไปหาเนื้อ", TH2="วาปไปหาเนื้อ แต่จะไม่เก็บให้", Callback=function()
                            Functions:B2C2Func("Meat/TpMeat");
                        end};
                        {type="Button", EN="Exit", EN2="Teleport to the exit door &  interact for you.", TH1="ออก", TH2="วาปไปที่ประตูทางออกแล้วกดออกให้", Callback=function()
                            Functions:B2C2Func("Meat/Exit");
                        end};
                        {type="Button", EN="Auto Run", EN2="Tween to the exit door.", TH1="ออโต้วิ่ง", TH2="ค่อยๆบินไปที่ประตูทางออก", Callback=function()
                            Functions:B2C2Func("Meat/Run");
                        end}; {type="Space"}, {type="Space"},
                        {type="Toggle", EN="ESP Ashina", EN2="Show Ashina's hitbox", TH1="ESP Ashina", TH2="มองเห็น Ashina", Path="Meat/ESP/Ashina", Callback=function(state)
                            B2C2Con.Meat.ESP.Ashina = state;
                            Functions:B2C2ESP("Meat/Ashina", state);
                        end};
                        {type="Toggle", EN="ESP Meats", EN2="Show meat's box", TH1="ESP เนื้อ", TH2="มองเห็นเนื้อ", Path="Meat/ESP/Meats", Callback=function(state)
                            B2C2Con.Meat.ESP.Meats = state;
                            Functions:B2C2ESP("Meat/Meats", state);
                        end};
                    }};
                    {Tab={at="B2C2", Title="Lever", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Enter Zone", EN2="Teleport & Interact with white door.", TH1="วาปเข้าด่าน", TH2="วาปไปที่ประตูสีขาวแล้วกดออกให้", Callback=function()
                            return Functions:B2C2Func("Lever/Enter");
                        end};
                        {type="Button", EN="Auto Levers", EN2="Teleport & Interact with levers.", TH1="ออโต้สับคันโยก", TH2="ออโต้สับคันโยกด้วยการวาป", Callback=function()
                            return Functions:B2C2Func("Lever/Auto");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Levers", EN2="Show lever's box & name", TH1="ESP คันโยก", TH2="มองเห็นคันโยก", Path="Lever/ESP/Levers", Callback=function(state)
                            B2C2Con.Lever.ESP.Levers = state;
                            Functions:B2C2ESP("Lever/Levers", state);
                        end};
                    }};
                    {Tab={at="B2C2", Title="Math", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport you to the cooking area ( Skip current section ).", TH1="ออโต้ผ่านด่าน", TH2="วาปไปที่ด่านถัดไป ( ข้ามด่านปัจจุบัน )", Callback=function()
                            return Functions:B2C2Func("Math");
                        end};
                        {type="Button", EN="Reveal Number", EN2="Create the correct symbol at the exit door.", TH1="แสดงตัวเลขที่ถูกต้อง", TH2="สร้างสัญลักษ์ที่ถูกต้องที่ประตูทางออก. ", Callback=function()
                            return Functions:B2C2ESP("Math", true);
                        end};
                    }};
                    {Tab={at="B2C2", Title="Gordon Ramsey", Icon="book-open", Path="B2C2"}, Data={
                        {type="Toggle", EN="Auto Complete", EN2="Cooking food for you. This isn't instant toggle so if you want to turn it off; You have to wait. ( Singleplayer )", TH1="ออโต้ผ่านด่าน", TH2="ทำอาหารให้แต่ใช้ได้แค่เวลาเล่นคนเดียว เวลากดปิดจะไม่ปิดทันที", Path="Cook/AutoCook"};
                        {type="Button", EN="Auto Run", EN2="Tween to the exit of this cave.", TH1="ออโต้วิ่ง", TH2="ค่อยๆบินไปที่ทางออกถ้ำ", Callback=function()
                            return Functions:B2C2Func("Cook/Run");
                        end};
                    }};
                    {Tab={at="B2C2", Title="Cursed", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Tween you to the entrance of Cursed Zone 2.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปที่ประตูทางเข้าด่าน 2", Callback=function()
                            return Functions:B2C2Func("Cursed/1");
                        end}; {type="Space"};
                        {type="Button", EN="Enter Zone", EN2="Tween you to Cursed Zone 2.", TH1="เข้าด่าน2", TH2="บินไปที่ด่าน 2", Callback=function()
                            return Functions:B2C2Func("Cursed/2");
                        end};
                        {type="Button", EN="Remove Monster", EN2="This is client side so if you are with your friend, tell them not to go to 2nd floor. You must click this before enter 2nd floor to make it work.", TH1="ลบผีทิ้ง", TH2="ต้องกดก่อนเดินขึ้นไปข้างบน และถ้ามากับเพื่อนบอกให้เพื่อนอยู่แต่ด้านล่าง", Callback=function()
                            return Functions:B2C2Func("Cursed/Remove");
                        end};
                    }};
                    {Tab={at="B2C2", Title="Kid", Icon="book-open", Path="B2C2"}, Data={
                        {type="Button", EN="Find Kid", EN2="Teleport to the kid.", TH1="หาเด็ก", TH2="วาปไปหาเด็ก", Callback=function()
                            return Functions:B2C2Func("Kid/Find");
                        end};
                        {type="Button", EN="Teleport To Gate", EN2="Teleport & Interact with white door.", TH1="วาปเข้าประตู", TH2="วาปเข้าประตูสีขาว", Callback=function()
                            return Functions:B2C2Func("Kid/Gate");
                        end};
                        {type="Toggle", EN="Anti Mother", EN2="Teleport to safe spot when mother is near.", TH1="หลบแม่", TH2="วาปกลับจุดเกิดเวลาเจอแม่", Path="Kid/Anti Mother"};
                        {type="Toggle", EN="ESP Mother", EN2="Show mother's hitbox.", TH1="ESP แม่", TH2="มองเห็นแม่", Path="Kid/ESP/Mother", Callback=function(state)
                            B2C2Con.Kid.ESP.Mother = state;
                            return Functions:B2C2ESP("Kid/Mother", state);
                        end}; {type="Space"}; {type="Space"};
                        {type="Button", EN="Auto Collect Notes", EN2="Teleport & Collect notes.", TH1="ออโต้เก็บโน๊ต", TH2="วาปและเก็บโน๊ต", Callback=function()
                            return Functions:B2C2Func("Kid/Notes");
                        end};
                    }};
                    {Tab={at="B2C2", Title="Nagisa", Icon="book-open", Path="B2C2"}, Data={
                        {type="Toggle", EN="Auto Get Cannon Balls", EN2="Teleport & Grab cannon balls when out of it.", TH1="ออโต้หยิบลูกปืนใหญ่", TH2="วาปและหยิบลูกปืนใหญ่เมื่อเหลือ 0", Path="Nagisa/Auto Get Cannon Balls"};
                        {type="Toggle", EN="Anti Nagisa Beam", EN2="Teleport to safe spot when nagisa uses her beam.", TH1="ออโต้หลบกลิ่นปาก", TH2="วาปไปที่ปลอดภัยเวลามันพ่นกลิ่นปาก", Path="Nagisa/Anti Nagisa Beam"}; {type="Space"};
                        {type="Toggle", EN="Auto Kill Nagisa Serpent", EN2="Teleport & Spam katana", TH1="ออโต้ฆ่า Nagisa Serpent", TH2="วาปและสแปมดาบ", Path="Nagisa/Auto Kill Nagisa Serpent"}; {type="Space"};
                    }};
                };
            });
            PackB2C3 = (Chapter == "B2C3" and {
                Tabs={
                    {Tab={at="B2C3", Title="Gozu & Mezu", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport the the entrance", TH1="ออโต้ผ่านด่าน", TH2="วาปไปที่ทางเข้า", Callback=function()
                            return Functions:B2C3Func("Gozu");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Heart", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Talk", EN2="Teleport to the NPC.", TH1="คุย", TH2="วาปไปหา NPC", Callback=function()
                            return Functions:B2C3Func("Heart/Talk");
                        end};
                        {type="Button", EN="Auto Hearts", EN2="Teleport & Collect hearts.", TH1="ออโต้เก็บหัวใจ", TH2="วาปเก็บหัวใจ", Callback=function()
                            return Functions:B2C3Func("Heart/Auto");
                        end}; {type="Space"};
                        {type="Button", EN="Auto Run", EN2="Teleport to the exit in the chase sequence.", TH1="ออโต้วิ่ง", TH2="วาปไปที่ทางออกในด่านวิ่ง", Callback=function()
                            return Functions:B2C3Func("Heart/Run");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Maze", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Auto Craft", EN2="Teleport, collect items and craft a torch for you.", TH1="ออโต้คราฟ", TH2="วาปเก็บไอเทมมาคราฟแท่งไฟ", Callback=function()
                            return Functions:B2C3Func("Maze/Craft");
                        end};
                        {type="Button", EN="Get Fire", EN2="Teleport & light up your torch. You must equip your torch to use this.", TH1="จุดไฟ", TH2="วาปไปจุดไฟแต่ต้องถือแท่งไฟก่อน", Callback=function()
                            return Functions:B2C3Func("Maze/Fire");
                        end};
                        {type="Button", EN="Escape", EN2="Teleport to the exit.", TH1="ออก", TH2="วาปไปที่ทางออก", Callback=function()
                            return Functions:B2C3Func("Maze/Escape");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Monster", EN2="Show monster's hitbox.", TH1="ESP ผี", TH2="มองเห็นผี", Path="Maze/ESP/GrinDemon", Callback=function(state)
                            B2C3Con.Maze.ESP.GrinDemon = state;
                            return Functions:B2C3ESP("Maze/GrinDemon", state);
                        end};
                    }};
                    {Tab={at="B2C3", Title="Bell", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Enter Zone", EN2="Teleport to the cutscene.", TH1="วาปเข้าด่าน", TH2="วาปไปที่คัตซีน", Callback=function()
                            return Functions:B2C3Func("Bell/Zone");
                        end};
                        {type="Button", EN="Kill All Flys", EN2="Teleport & kill all flys.", TH1="ออโต้ฆ่าแมลง", TH2="วาปฆ่าแมลง", Callback=function()
                            return Functions:B2C3Func("Bell/Flys");
                        end};
                        {type="Button", EN="Auto Bell", EN2="Auto ring the bell and attack the monster.", TH1="ออโต้ระฆัง", TH2="ออโต้ตีระฆังและเดี่ยวกับผี", Callback=function()
                            return WindUI:Notify({
                                Title = "<font color='rgb(255,0,0)'>WARNING</font>",
                                Content = "Hold on, Script is Intilizing, Do not press again.",
                                Icon = "circle-alert",
                                Duration = 10,
                            }), tk.delay(15, function()
                                return WindUI:Notify({
                                    Title = "<font color='rgb(255,0,0)'>WARNING</font>",
                                    Content = "Trust the process lol, it seem like it's not working but it actually work.",
                                    Icon = "circle-alert",
                                    Duration = 10,
                                });
                            end), Functions:B2C3Func("Bell/Auto");
                        end}; {type="Space"};
                        {type="Button", EN="Teleport To Door", EN2="Teleport to the puzzle door but does not complete for you.", TH1="วาปไปที่ประตู", TH2="วาปไปที่ประตูเพื่อแก้ปริศนา", Callback=function()
                            return Functions:B2C3Func("Bell/TpDoor");
                        end};
                        {type="Button", EN="Auto Complete Puzzle", EN2="Auto complete the puzzle but you have to be near the door.", TH1="ออโต้แก้ปริศนา", TH2="ออโต้แก้ปริศนาแต่ต้องอยู่ใกล้ประตู", Callback=function()
                            return Functions:B2C3Func("Bell/Puzzle");
                        end};
                        {type="Button", EN="Auto Run", EN2="Teleport to the exit.", TH1="ออโต้วิ่ง", TH2="วาปไปที่ทางออก", Callback=function()
                            return Functions:B2C3Func("Bell/Run");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Enzukai", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Enter Zone", EN2="Teleport to enzukai.", TH1="วาปเข้าด่าน", TH2="วาปไปที่ผี", Callback=function()
                            return Functions:B2C3Func("Enzukai/Enter");
                        end};
                        {type="Button", EN="Auto Complete", EN2="Auto interact with Enzukai.", TH1="ออโต้ผ่านด่าน", TH2="ออโต้คุยกับผีตอนอยู่บนแพ", Callback=function()
                            return Functions:B2C3Func("Enzukai/Auto");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Father", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Disable Isamu", EN2="Ignore his action bro he's not gonna kill us.", TH1="เพิกเฉยต่อการโจมตีของ Isamu", TH2="สนใจทำไมก็แค่ผีตัวนึง", Callback=function()
                            return Functions:B2C3Func("Father/Isamu");
                        end};
                        {type="Button", EN="Teleport To Safe Spot", EN2="Your sanity will drain but last long enough to survive each night.", TH1="วาปไปจุดที่ปลอดภัย", TH2="ค่าสติจะลดไวขึ้นแต่ก็อยู่ได้นานพอสำหรับคืนถัดไป", Callback=function()
                            return Functions:B2C3Func("Father/Auto");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Train", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Enter Zone", EN2="Teleport to the arrival area.", TH1="วาปเข้าด่าน", TH2="วาปไปที่รถไฟ", Callback=function()
                            return Functions:B2C3Func("Train");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Larves", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the exit.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปทางออก", Callback=function()
                            return Functions:B2C3Func("Larves");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Larves", EN2="Show larve's hitbox.", TH1="ESP หนอน", TH2="มองเห็นหนอน", Path="Larves/ESP/Larves", Callback=function(state)
                            B2C3Con.Larves.ESP.Larves = state;
                            return Functions:B2C3ESP("Larves/Larves", state);
                        end};
                        {type="Toggle", EN="ESP Soldier", EN2="Show soldier's hitbox.", TH1="ESP ทหาร", TH2="มองเห็นทหาร", Path="Larves/ESP/Soldier", Callback=function(state)
                            B2C3Con.Larves.ESP.Soldier = state;
                            return Functions:B2C3ESP("Larves/Soldier", state);
                        end};
                        {type="Toggle", EN="ESP Boogey", EN2="Show Boogeyman's hitbox.", TH1="ESP บูกี้แมน", TH2="มองเห็นบูกี้แมน", Path="Larves/ESP/Boogey", Callback=function(state)
                            B2C3Con.Larves.ESP.Boogey = state;
                            return Functions:B2C3ESP("Larves/Boogey", state);
                        end};
                    }};
                    {Tab={at="B2C3", Title="Mud", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the exit.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปทางออก", Callback=function()
                            return Functions:B2C3Func("Mud");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Yurei", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Teleport To House", EN2="Teleport to the house; right at the interaction.", TH1="วาปเข้าบ้าน", TH2="วาปไปที่บ้าน จุดที่เอาไว้แก้ปริศนา", Callback=function()
                            return Functions:B2C3Func("Yurei/House");
                        end};
                        {type="Button", EN="Auto Click Items", EN2="Click all cursed items.", TH1="ออโต้กดไอเทม", TH2="ออโต้กดคลิกไอเทมที่ถูกต้อง", Callback=function()
                            return Functions:B2C3Func("Yurei/Click");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Boss", Icon="book-open", Path="B2C3"}, Data={
                        {type="Toggle", EN="Auto Complete", EN2="Auto kill Yurei. Do not turn this on before the fight has started.", TH1="ออโต้ผ่านด่าน", TH2="ออโต้ฆ่าผี ห้ามเปิดก่อนที่สงครามจะเริ่ม", Path="Boss/AutoKillYurei"}; {type="Space"};
                        {type="Button", EN="Clear Map", EN2="Remove map's border.", TH1="เคลียพื้นที่", TH2="ลบกำแพงแมพออก", Callback=function()
                            return Functions:B2C3Func("Boss/Clear");
                        end};
                        {type="Button", EN="Teleport To Safe Spot", EN2="Teleport you outside the border.", TH1="วาปไปจุดที่ปลอดภัย", TH2="วาปออกไปนอกกำแพงแมพ", Callback=function()
                            return Functions:B2C3Func("Boss/TpSafe");
                        end};
                        {type="Button", EN="Get Katanas", EN2="Teleport & grab katanas", TH1="เก็บดาบ", TH2="วาปเก็บดาบ", Callback=function()
                            return Functions:B2C3Func("Boss/Katanas");
                        end};
                    }};
                    {Tab={at="B2C3", Title="Hell", Icon="book-open", Path="B2C3"}, Data={
                        {type="Button", EN="Auto Run", EN2="Teleport to the exit.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปทางออก", Callback=function()
                            return Functions:B2C3Func("Hell/Run");
                        end};
                    }};
                };
            });
            PackB2C4 = (Chapter == "B2C4" and {
                Tabs = {
                    {Tab={at="B2C4", Title="Bypass", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Patched Inventory", EN2="Sometimes your inventory just stuck on your screen and you can't do anything except rejoin BUT this button will fix it.", TH1="แก้บัคกระเป๋า", TH2="บางทีกระเป๋ามันค้างอยู่กลางจอละมันต้องออกเข้าใหม่ แต่กดปุ่มนี้แก้ได้", Callback=Functions.INVBP};
                        {type="Button", EN="Patched Reporter Cutscene", EN2="In the 6 floor building, there is an NPC for you to talk with but sometime the anti cheat can break your cutscene.", TH1="แก้บัคอัคซีนของนักข่าว", TH2="ในด่านตึก 6 ชั้นจะมี NPC ให้เราไปคุยแล้วในบางตัวรันมันโดนกันโปรทำบัค ให้กดปุ่มนี้เวลาบัค", Callback=Functions.B2C4BP1};
                        {type="Button", EN="Patched Mother's Game", EN2="In the minigame where mother will be asking you questions and you have to answer, the anti cheat will stop the answer from appearing, use this to fix it.", TH1="แก้บัคคำถามของแม่", TH2="ในด่านมินิเกมที่แม่จะถามคำถามแล้วเราต้องตอบ ในบางตัวรันมันโดนกันโปรทำบัค ให้กดปุ่มนี้เวลาบัค", Callback=Functions.B2C4BP2};
                    }};
                    {Tab={at="B2C4", Title="Cave", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the exit of this cave.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปที่ทางออกถ้ำ", Callback=function()
                            return Functions:B2C4Func("Cave");
                        end};
                    }};
                    {Tab={at="B2C4", Title="City", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the white door.", TH1="ออโต้ผ่านด่าน", TH2="วาปไปที่ประตูสีขาว", Callback=function()
                            return Functions:B2C4Func("City/Auto");
                        end}; {type="Space"};
                        {type="Button", EN="Destroy Glass", EN2="Remove glasses from the floor.", TH1="ลบกระจกออก", TH2="ลบกระจกที่อยู่บนพื้นออก", Callback=function()
                            return Functions:B2C4Func("City/Glass");
                        end};
                        {type="Toggle", EN="ESP Glass", EN2="Show glass's hitbox.", TH1="ESP กระจก", TH2="มองเห็นกระจก", Path="City/ESP/Glass", Callback=function(state)
                            B2C4Con.City.ESP.Glass = state;
                            return Functions:B2C4ESP("City/Glass", state);
                        end};
                        {type="Toggle", EN="ESP Enzukai", EN2="Show Enzukai's hitbox.", TH1="ESP ผี", TH2="มองเห็นผี", Path="City/ESP/Enzukai", Callback=function(state)
                            B2C4Con.City.ESP.Enzukai = state;
                            return Functions:B2C4ESP("City/Enzukai", state);
                        end};
                    }};
                    {Tab={at="B2C4", Title="Office", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Talk", EN2="Teleport to NPC.", TH1="คุย", TH2="วาปไปหา NPC", Callback=function()
                            return Functions:B2C4Func("Office/Talk");
                        end};
                        {type="Button", EN="Auto Codes", EN2="You have to interact with the keypad first.", TH1="ออโต้ใส่โค้ด", TH2="ต้องกดปุ่มที่ประตูก่อน", Callback=function()
                            return Functions:B2C4Func("Office/Auto");
                        end}; {type="Space"};
                        {type="Button", EN="Collect Item", EN2="Teleport, collect item, and escape. (Rooftop)", TH1="ออโต้ผ่านด่าน", TH2="วาปเก็บไอเทมและออก (ชั้นดาดฟ้า)", Callback=function()
                            return Functions:B2C4Func("Office/Top");
                        end};
                    }};
                    {Tab={at="B2C4", Title="Mall", Icon="book-open", Path="B2C4"}, Data={
                        {type="Paragraph", Title="Tutorial", Desc=[[<font color="#ff0000">You don't need auto coins</font>, <font color="#ffffff">All you have to do is punch & grab speaker then place it and escape. You can check YouTube video to understand more about it.</font>]]};
                        {type="Button", EN="Auto Walkie Talkis", EN2="Teleport & interact with walkie talkie", TH1="ออโต้กดวอสื่อสาร", TH2="วาปและกดใช้งาน", Callback=function()
                            return Functions:B2C4Func("Mall/Talk");
                        end};
                        {type="Button", EN="Auto Trigger Escape", EN2="Teleport to the entrance to trigger the game event.", TH1="ออโต้หลบหนี", TH2="วาปไปที่ทางเข้าเพื่อเริ่คัตซีน", Callback=function()
                            return Functions:B2C4Func("Mall/Trigger");
                        end};
                        {type="Button", EN="Auto Punch Eyes", EN2="Teleport & punch eyes.", TH1="ออโต้ต่อยดวงตา", TH2="วาปและต่อยดวงตา", Callback=function()
                            return Functions:B2C4Func("Mall/Eyes");
                        end};
                        {type="Button", EN="Grab Speaker", EN2="Teleport & grab the speaker.", TH1="เก็บลำโพง", TH2="วาปและเก็บลำโพง", Callback=function()
                            return Functions:B2C4Func("Mall/Grab");
                        end};
                        {type="Button", EN="Place Speaker", EN2="Teleport & place the speaker.", TH1="วางลำโพลง", TH2="วาปและวางลำโพง", Callback=function()
                            return Functions:B2C4Func("Mall/Place");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Coins", EN2="Show coin's box.", TH1="ESP เหรียญ", TH2="มองเห็นเหรียญ", Path="Mall/ESP/Coins", Callback=function(state)
                            B2C4Con.Mall.ESP.Coins = state;
                            return Functions:B2C4ESP("Mall/Coins", state);
                        end};
                        {type="Toggle", EN="ESP Walkie Talkies", EN2="Show walkie talkie's box.", TH1="ESP วอสื่อสาร", TH2="มองเห็นวอสื่อสาร", Path="Mall/ESP/Glass", Callback=function(state)
                            B2C4Con.Mall.ESP.Walkie = state;
                            return Functions:B2C4ESP("Mall/Talk", state);
                        end};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox.", TH1="ESP ผี", TH2="มองเห็นผี", Path="Mall/ESP/Monsters", Callback=function(state)
                            B2C4Con.Mall.ESP.Monsters = state;
                            return Functions:B2C4ESP("Mall/Monsters", state);
                        end}; {type="Space"}; {type="Divider"}; {type="Space"};
                        {type="Button", EN="Auto Chase 1", EN2="The floor at the end of the chase must fall so that mean everything must be loaded before you use this. You can watch my YouTube tutorial to use this one.", TH1="ออโต้วิ่ง 1", TH2="พื้นห้างในตอนท้ายพัง หมายความว่าก่อนกดใช้งานต้องมั่นใจก่อนว่าแมพโหลดเสร็จแล้ว หรือลองเปิด YouTube ดูก็ได้", Callback=function()
                            return Functions:B2C4Func("Mall/Chase1");
                        end};
                        {type="Button", EN="Auto Chase 2", EN2="Teleport to the elevator.", TH1="ออโต้วิ่ง 2", TH2="วาปไปที่ลิฟ", Callback=function()
                            return Functions:B2C4Func("Mall/Chase2");
                        end};
                    }};
                    {Tab={at="B2C4", Title="Car", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Auto Collect Car Parts", EN2="Teleport & collect all car parts.", TH1="ออโต้เก็บชิ้นส่วนรถ", TH2="วาปแล้วเก็บชิ้นส่วนรถทั้งหมด", Callback=function()
                            return Functions:B2C4Func("Car/Collect");
                        end};
                        {type="Button", EN="Answer", EN2="Give mother the correct answer.", TH1="ตอบคำถาม", TH2="แม่!!! ผมตอบถูกแล้ว", Callback=function()
                            return Functions:B2C4Func("Car/Answer");
                        end};
                    }};
                    {Tab={at="B2C4", Title="Drawing", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Teleport Outside", EN2="Teleport to the gate.", TH1="วาปไปข้างนอก", TH2="วาปไปที่ทางเข้าหมู่บ้าน", Callback=function()
                            return Functions:B2C4Func("Draw/Outside");
                        end};
                        {type="Button", EN="Teleport Inside", EN2="Enter the village without trigger Senzai. Make sure you go back to the gat entrance after reaching 3/4 pillars so the game continue.", TH1="วาปไปข้างใน", TH2="วาปไปในหมู่บ้านทำให้ผีไม่เกิด โดยต้องกลับไปที่ทางเข้าเพื่อให้ผีเกิดตอนได้ครบ3/4เพื่อให้เล่นต่อได้", Callback=function()
                            return Functions:B2C4Func("Draw/Inside");
                        end};
                        {type="Button", EN="Teleport To Pad", EN2="Teleport to the drawing pad.", TH1="วาปไปที่แท่น", TH2="วาปไปที่แท่นวาดรูป", Callback=function()
                            return Functions:B2C4Func("Draw/Tp");
                        end};
                        {type="Button", EN="Draw", EN2="This only draw for you; Enter by yourself.", TH1="วาดรูป", TH2="วาดอย่างเดียว ไม่มีการวาปให้", Callback=function()
                            return Functions:B2C4Func("Draw/Draw");
                        end};
                        {type="Button", EN="Teleport To Pillar", EN2="Teleport to the pillar.", TH1="วาปไปที่เสา", TH2="วาปไปที่เสาผี", Callback=function()
                            return Functions:B2C4Func("Draw/Pillar");
                        end};
                        {type="Button", EN="Collect Quest Items", EN2="Teleport & collect item dropped.", TH1="ออโต้เก็บไอเทมจากผี", TH2="วาปและเก็บไอเทมที่ดรอปจากผี", Callback=function()
                            return Functions:B2C4Func("Draw/Item");
                        end}; {type="Space"};
                        {type="Toggle", EN="ESP Senzai", EN2="Show Senzai's hitbox.", TH1="ESP ผี", TH2="มองเห็นผี", Path="Draw/ESP/Senzai", Callback=function(state)
                            B2C4Con.Draw.ESP.Senzai = state;
                            return Functions:B2C4ESP("Draw/Senzai", state);
                        end};
                        {type="Toggle", EN="ESP Ingredients", EN2="Show ingredient's box.", TH1="ESP วัตถุดิบ", TH2="มองเห็นวัตถุดิบ", Path="Draw/ESP/Ingredients", Callback=function(state)
                            B2C4Con.Draw.ESP.Ingredients = state;
                            return Functions:B2C4ESP("Draw/Ingredients", state);
                        end};
                        {type="Toggle", EN="ESP Drawings", EN2="Show pad's box.", TH1="ESP แท่นวาดรูป", TH2="มองเห็นแท่นวาดรูป", Path="Draw/ESP/Pad", Callback=function(state)
                            B2C4Con.Draw.ESP.Drawings = state;
                            return Functions:B2C4ESP("Draw/Drawings", state);
                        end};
                    }};
                    {Tab={at="B2C4", Title="Enzukai", Icon="book-open", Path="B2C4"}, Data={
                        {type="Button", EN="Godmode", EN2="Disable monsters from touching you.", TH1="อมตะ", TH2="กันไม่ให้ผีแตะตัวได้", Callback=function()
                            return Functions:B2C4Func("Godmode");
                        end}; {type="Space"}; {type="Divider"}; {type="Space"};
                        {type="Button", EN="Auto Help Survivors", EN2="Teleport & interact with survivors.", TH1="ออโต้ช่วยคน", TH2="วาปและช่วยเหลือ", Callback=function()
                            return Functions:B2C4Func("Survivors");
                        end};
                        {type="Toggle", EN="ESP Survivors", EN2="Show survivor's box.", TH1="ESP ผู้รอดชีวิต", TH2="มองเห็นผู้รอดชีวิต", Path="Enzukai/ESP/Survivors", Callback=function(state)
                            B2C4Con.Enzukai.ESP.Survivors = state;
                            return Functions:B2C4ESP("Survivors", state);
                        end}; {type="Space"}; {type="Divider"}; {type="Space"};
                        {type="Toggle", EN="Auto Kill Enzukai-Ryu", EN2="Auto get supercharge and kill Enzukai.", TH1="ออโต้ฆ่า Enzukai", TH2="ออโต้ชาจและฆ่า Enzukai", Path="Enzukai/Auto Kill Enzukai-Ryu"};
                        {type="Toggle", EN="Auto Kill Monsters", EN2="Auto kill Enzukai's follower.", TH1="ออโต้ฆ่าผี", TH2="ออโต้ฆ่าลูกน้อง Enzukai", Path="Enzukai/Auto Kill Enzukai Followers"};
                        {type="Toggle", EN="ESP Followers", EN2="Show follower's box.", TH1="ESP ผี3ตัว", TH2="มองเห็นผีลุกน้องEnzukai", Path="Enzukai/ESP/Followers", Callback=function(state)
                            B2C4Con.Enzukai.ESP.Followers = state;
                            return Functions:B2C4ESP("Followers", state);
                        end};
                    }};
                    {Tab={at="B2C4", Title="Boss", Icon="book-open", Path="B2C4"}, Data={
                        {type="Toggle", EN="Auto Kill Final Boss", EN2="Auto kill EnzukaiRyu-Jin.", TH1="ออโต้ฆ่าบอส", TH2="ออโต้ฆ่า EnzukaiRyu-Jin", Path="Final/Auto Kill Final Boss"};
                    }};
                };
            });
            PackB3C1 = (Chapter == "B3C1" and {
                Tabs={
                    {Tab={at="B3C1", Title="City", Icon="book-open", Path="B3C1"}, Data={
                        {type="Button", EN="Kill All Gatas", EN2="Teleport & fire a shot with client validation.", TH1="ยิง Gatas", TH2="วาปไปยิง Gatas พร้อมการยืนยันจาก Client", Callback=function()
                            return Functions:B3C1Func("City/Kill");
                        end};
                        {type="Button", EN="Interact All Dead Bodies", EN2="Teleport to dead bodies and interact.", TH1="รายงานศพ", TH2="วาปไปรายงานศพ", Callback=function()
                            return Functions:B3C1Func("City/Body");
                        end};
                        {type="Button", EN="Teleport To Mika", EN2="Watch she's gone.", TH1="วาปไปหา Mika", TH2="ไปดูฉากสิ้นหวัง", Callback=function()
                            return Functions:B3C1Func("City/Mika");
                        end};
                        {type="Button", EN="Teleport To Hideo/Door", EN2="Tell Hideo a sad story.", TH1="วาปไปหา Hideo", TH2="ไปเล่าเรื่องราวสิ้นหวัง", Callback=function()
                            return Functions:B3C1Func("City/Hideo");
                        end};
                        {type="Button", EN="Cut The Chains", EN2="Teleport & magically cut the chain.", TH1="ตัดโซ่", TH2="วาปและตัดโซ่แบบงงๆ", Callback=function()
                            return Functions:B3C1Func("City/Cut");
                        end}; {type="Space"}; {type="Space"};
                        {type="Toggle", EN="ESP Gatas", EN2="Show Gatas' hitbox", TH1="ESP Gatas", TH2="มองเห็น Gatas", Path="City/ESP/Gatas", Callback=function(state)
                            B3C1Con.City.ESP.Gatas = state;
                            return Functions:B3C1ESP("City/Gatas", state);
                        end};
                        {type="Toggle", EN="ESP Dead Bodies", EN2="Show dead bodies", TH1="ESP ศพ", TH2="มองเห็นศพ", Path="City/ESP/Bodies", Callback=function(state)
                            B3C1Con.City.ESP.Bodies = state;
                            return Functions:B3C1ESP("City/Bodies", state);
                        end};
                    }};
                    {Tab={at="B3C1", Title="School", Icon="book-open", Path="B3C1"}, Data={
                        {type="Button", EN="Grab Medical Kit", EN2="Magically grab it.", TH1="หยิบกล่องปฐมพยาบาล", TH2="หยิบกล่องปฐมพยาบาลแบบงงๆ", Callback=function()
                            return Functions:B3C1Func("School/Med");
                        end};
                        {type="Button", EN="Heal Hideo", EN2="Magically teleport to him & heal.", TH1="รักษา Hideo", TH2="วาปไปแบบงงๆแล้วรักษา", Callback=function()
                            return Functions:B3C1Func("School/Heal");
                        end};
                        {type="Button", EN="Read Note", EN2="Teleport & read note.", TH1="อ่านโน๊ต", TH2="วาปไปอ่านโน๊ต", Callback=function()
                            return Functions:B3C1Func("School/Note");
                        end};
                        {type="Button", EN="Freeze Spiders", EN2="Permanently stop spiders from moving.", TH1="หยุดแมงมุม", TH2="ทำให้แมงมุมขยับไม่ได้แบบถาวร", Callback=function()
                            return Functions:B3C1Func("School/Freeze");
                        end};
                        {type="Button", EN="Kill Spiders", EN2="Teleport & kill all spiders", TH1="ฆ่าแมงมุม", TH2="วาปฆ่าแมงมุมทั้งหมด", Callback=function()
                            return Functions:B3C1Func("School/Spider");
                        end};
                        {type="Button", EN="Exit", EN2="Teleport to exit door.", TH1="ออก", TH2="วาปไปที่ประตูทางออก", Callback=function()
                            return Functions:B3C1Func("School/Exit");
                        end};
                        {type="Button", EN="Enter Forest", EN2="Teleport to the forest.", TH1="เข้าป่า", TH2="วาปเข้าป่า", Callback=function()
                            return Functions:B3C1Func("School/Forest");
                        end};
                        {type="Toggle", EN="ESP Akari", EN2="Show Akari's hitbox.", TH1="ESP Akari", TH2="มองเห็น Akari", Path="School/ESP/Akari", Callback=function(state)
                            B3C1Con.School.ESP.Akari = state;
                            return Functions:B3C1ESP("Akari", state);
                        end};
                    }};
                    {Tab={at="B3C1", Title="Forest", Icon="book-open", Path="B3C1"}, Data={
                        {type="Button", EN="Teleport To IJO Entrance", EN2="Teleport to the cave entrance for cutscene.", TH1="วาปไปที่ทางเข้าถ้ำ", TH2="วาปไปที่ทางเข้าถ้ำเพื่อเริ่มฉากต่อสู้", Callback=function()
                            return Functions:B3C1Func("Forest/Cave");
                        end};
                        {type="Button", EN="Auto Fix Generators", EN2="Teleport & fix generators.", TH1="ซ่อม Generator", TH2="วาปไปซ่อม Generator", Callback=function()
                            return Functions:B3C1Func("Forest/Generator");
                        end}; {type="Space"}; {type="Space"};
                        {type="Toggle", EN="ESP Mizuno", EN2="Show Mizuno's hitbox.", TH1="ESP Mizuno", TH2="มองเห็น Mizuno", Path="Forest/ESP/Mizuno", Callback=function(state)
                            B3C1Con.Forest.ESP.Mizuno = state;
                            return Functions:B3C1ESP("Mizuno", state);
                        end};
                    }};
                    {Tab={at="IJO", Title="IJO", Icon="book-open", Path="B3C1"}, Data={
                        {type="Button", EN="Grab Keycard", EN2="Teleport & collect keycard. <font color='rgb(255,0,0)'>You must open the gate or termianl & valve won't spawn.</font>", TH1="เก็บคีย์การ์ด", TH2="วาปไปเก็บคีย์การ์ด", Callback=function()
                            return Functions:B3C1Func("IJO/Keycard");
                        end};
                        {type="Button", EN="Enter Codes", EN2="Magically enter the code from anywhere.", TH1="ใส่รหัส", TH2="ใส่รหัสจากที่ไหนก็ได้แบบงงๆ", Callback=function()
                            return Functions:B3C1Func("IJO/PASS");
                        end};
                        {type="Button", EN="Place C4 (1)", EN2="Teleport & place C4.", TH1="วางระเบิด C4", TH2="วาปไปวางระเบิด C4", Callback=function()
                            return Functions:B3C1Func("IJO/C4");
                        end};
                        {type="Button", EN="Place C4 (2)", EN2="Teleport & place C4 at Netamo.", TH1="วางระเบิด C4 ที่ผี", TH2="วาปไปวางระเบิด C4 ที่ผี", Callback=function()
                            return Functions:B3C1Func("IJO/C4_2");
                        end}; {type="Space"};
                        {type="Button", EN="Trigger Leave Event", EN2="Teleport & attempt to exit IJO Place to continue the game.", TH1="วาปไปที่ทางออก IJO", TH2="วาปไปที่ทางออก IJO เพื่อให้เกมดำเนินต่อ", Callback=function()
                            return Functions:B3C1Func("IJO/Exit");
                        end};
                        {type="Button", EN="Activate Terminals", EN2="Teleport & activate terminals.", TH1="เปิด terminals", TH2="วาปไปเปิด terminals", Callback=function()
                            return Functions:B3C1Func("IJO/Terminal");
                        end};
                        {type="Button", EN="Turn Valves", EN2="Teleport & turn valves.", TH1="เปิดวาล์ว", TH2="วาปไปเปิดวาล์ว", Callback=function()
                            return Functions:B3C1Func("IJO/Valve");
                        end};
                        {type="Button", EN="Hit Skill Check", EN2="Enter the 'Lock Threat' minigame by yourself. Only press this button by the amout of circles on screen.", TH1="กดสกิล", TH2="กดเพื่อเริ่มมินิเกม 'Lock Threat' ด้วยตัวเองแล้วค่อยกดออโต้ตามจำนวนวงกลมบนหน้าจอ", Callback=function()
                            return Functions:B3C1Func("IJO/Threat");
                        end}; {type="Space"}; {type="Space"};
                        {type="Toggle", EN="ESP HogoGuntai", EN2="Show HogoGuntai's hitbox.", TH1="ESP HogoGuntai", TH2="มองเห็น HogoGuntai", Path="IJO/ESP/HogoGuntai", Callback=function(state)
                            B3C1Con.IJO.ESP.HogoGuntai = state;
                            return Functions:B3C1ESP("HogoGuntai", state);
                        end};
                    }};
                    {Tab={at="B3C1", Title="Water", Icon="book-open", Path="B3C1"}, Data={ {type="Space"},
                        {type="Button", EN="Complete Stair", EN2="Teleport to the end of stair.", TH1="จบด่านบันได", TH2="วาปไปข้างล่างบันได", Callback=function()
                            return Functions:B3C1Func("Water/Stair");
                        end}; {type="Space"};
                        {type="Button", EN="Main Switch", EN2="Teleport & interact with the main switch.", TH1="เปิดสวิตช์หลัก", TH2="วาปไปเปิดสวิตช์หลัก", Callback=function()
                            return Functions:B3C1Func("Water/Main");
                        end};
                        {type="Button", EN="Auto Wire", EN2="Magically interact with the all boxes.", TH1="เสียบสายไฟอัตโนมัติ", TH2="วาปไปเสียบสายไฟอัตโนมัติ", Callback=function()
                            return Functions:B3C1Func("Water/Wire");
                        end}; {type="Space"}; {type="Space"};
                        {type="Toggle", EN="ESP Baigai", EN2="Show Baigai's hitbox.", TH1="ESP Baigai", TH2="มองเห็น Baigai", Path="Water/ESP/Baigai", Callback=function(state)
                            B3C1Con.Water.ESP.Baigai = state;
                            return Functions:B3C1ESP("Baigai", state);
                        end};
                    }};
                };
            });
            PackWitchTrial = (Chapter == "WitchTrial" and {
                Tabs={
                    {Tab={at="WitchTrial", Title="Witch Trial", Icon="ghost", Path="WitchTrial"}, Data={
                        {type="Button", EN="Auto Complete", EN2="Teleport to the end of the map.", TH1="ออโต้จบเกม", TH2="วาปไปที่จุดจบแมพ", Callback=function()
                            Functions.WitchTrialFunc("Complete");
                        end};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox", TH1="ESP ผี", TH2="มองเห็นมอนสเตอร์", Path="WitchTrial/ESP/Monsters", Callback=function(state)
                            Config.WitchTrial.ESP.Monsters = state;
                            return Functions.WitchTrialESP("Monsters", state);
                        end}; {type="Space"},
                        {type="Button", EN="Teleport To Fireplace 1", EN2="This is where you burn the butterfly A.", TH1="วาปไปที่เตาเผา 1", TH2="เผาผีเสื้ออันแรก", Callback=function()
                            Functions.WitchTrialFunc("Fire1");
                        end},
                        {type="Button", EN="Teleport To Fireplace 2", EN2="This is where you burn the butterfly B.", TH1="วาปไปที่เตาเผา 2", TH2="เผาผีเสื้ออันที่สอง", Callback=function()
                            Functions.WitchTrialFunc("Fire2");
                        end}, {type="Space"},
                        {type="Button", EN="Get Butterfly", EN2="Teleport to witches and grab butterflies.", TH1="เก็บผีเสื้อ", TH2="วาปไปเก็บผีเสื้อจากแม่มด", Callback=function()
                            Functions.WitchTrialFunc("Butterfly");
                        end};
                    }};
                };
            });
            PackHalloweenTrial = (Chapter == "HalloweenTrial" and {
                Tabs = ((PlaceId == 7633631103 or PlaceId == 7633631351) and {
                    {Tab={at="HalloweenTrial", Title="Halloween Trial", Icon="ghost", Path="HalloweenTrial"}, Data={
                        {type="Button", EN="Collect All Candies", EN2="Teleport & collect all candies.", TH1="เก็บลูกอมทั้งหมด", TH2="วาปเก็บลูกอมทั้งหมด", Callback=function()
                            Functions:HalloweenTrialFunc("Candy");
                        end};
                        {type="Button", EN="Auto Complete", EN2="Teleport & collect all cursed and burn.", TH1="ออโต้ผ่านด่าน", TH2="วาปเก็บของแล้วเผา", Callback=function()
                            Functions.HalloweenTrialFunc();
                        end}; {type="Space"}, {type="Space"};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=function(state)
                            Config.HalloweenTrial.ESP.Monsters = state;
                            Functions.HalloweenTrialESP("Monster", state)
                        end};
                        {type="Toggle", EN="ESP Candies", EN2="Show candy's hitbox & name", Path="ESP/Candy", TH1="ESP ลูกอม", TH2="มองเห็นลูกอม", Callback=function(state)
                            Config.HalloweenTrial.ESP.Candy = state;
                            Functions.HalloweenTrialESP("Candy", state)
                        end};
                    }};
                }) or (PlaceId == 7633631511 and {
                    {Tab={at="HalloweenTrial", Title="Halloween Trial", Icon="ghost", Path="HalloweenTrial"}, Data={
                        {type="Button", EN="Collect All Candies", EN2="Teleport & collect all candies.", TH1="เก็บลูกอมทั้งหมด", TH2="วาปเก็บลูกอมทั้งหมด", Callback=function()
                            Functions:HalloweenTrialFunc("Candy");
                        end};
                        {type="Button", EN="Auto Potion", EN2="Teleport & make a potion.", TH1="ออโต้ปรุงยา", TH2="วาปปรุงยา", Callback=function()
                            Functions:HalloweenTrialFunc("Potion");
                        end}; {type="Space"}, {type="Space"};
                        {type="Toggle", EN="ESP Monsters", EN2="Show monster's hitbox & name", Path="ESP/Monsters", TH1="ESP ผี", TH2="มองเห็นผี", Callback=function(state)
                            Config.HalloweenTrial.ESP.Monsters = state;
                            Functions.HalloweenTrialESP("AI", state)
                        end};
                        {type="Toggle", EN="ESP Candies", EN2="Show candy's hitbox & name", Path="ESP/Candy", TH1="ESP ลูกอม", TH2="มองเห็นลูกอม", Callback=function(state)
                            Config.HalloweenTrial.ESP.Candy = state;
                            Functions.HalloweenTrialESP("Candy", state)
                        end};
                    }};
                });
            });
        }; end))();

        CoruTask.New("B1C4@Sama", function()
            if PlaceId ~= 7251867574 and PlaceId ~= 7265397848 then
                return;
            end;
            
            local SAFESAMA = CFr(2823, 155, 2490); while true do
                local CHs=GetChildren(W.GameHearts); for i=1, #CHs do
                    if not B1C4Con.Map4.AutoKillSama or CoreDestroyed then
                        CoruTask.Close("B1C4@Sama");
                    end; local v=CHs[i]; if v.Parent then
                        local Root = FindFirstChild(v, "Root");
                        if not Root then continue; end;
                        local CFH = Root.CFrame;
                        while not FindFirstChild(v, "Destroyed") and B1C4Con.Map4.AutoKillSama and not CoreDestroyed do
                            while Cam.FieldOfView > 71 do
                                Tp(HumRSelf, SAFESAMA); twait(0.03);
                            end;

                            while selc.Parent and Functions:ToolNow("Katana") and Cam.FieldOfView < 72 and not FindFirstChild(v, "Destroyed") do
                                Tp(HumRSelf, CFH); Functions:ToolActive("Katana"); twait(0.1);
                            end; twait(0.1);
                        end;
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B1C4@Saigomo", function()
            if PlaceId ~= 7251867574 and PlaceId ~= 7265397848 then
                return;
            end;
            
            local SaiConnection = nil;
            local SAFESAIGOMO = CFr(2718.18, 266.32, 2537.03);
            local BossBattle = WaitForChild(W, "BossBattle", 9e9);
            local Saigomo = WaitForChild(BossBattle, "Saigomo", 9e9);
            local HumRSai = WaitForChild(Saigomo, "HumanoidRootPart", 9e9);
            local Sound = WaitForChild(HumRSai, "roar", 9e9);

            if Sound and Sound.Parent then
                local CHs = {
                    WaitForChild(Saigomo, "SpiderHitbox", 9e9),
                    WaitForChild(Saigomo, "hitbox1", 9e9),
                    WaitForChild(Saigomo, "hitbox2", 9e9),
                }; for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Touch = WaitForChild(v, "TouchInterest", 9e9);
                        if Touch then Touch:Destroy(); end;
                    end;
                end; Saigomo.SpiderHitbox.Size = Vec3(50, 50, 50);
            end;

            while true do
                if not B1C4Con.Map4.AutoKillSaigomo or CoreDestroyed then
                    if SaiConnection then
                        SaiConnection:Disconnect();
                        SaiConnection = nil;
                    end; CoruTask.Close("B1C4@Saigomo");
                end; if not SaiConnection then
                    SaiConnection = H.Heartbeat:Connect(function()
                        if not selc.Parent or not HumRSelf.Parent then return; end;
                        if not Sound.Parent or not HumRSai.Parent then return; end;

                        if Sound.IsPlaying then
                            Tp(HumRSelf, SAFESAIGOMO);
                        else
                            if Functions:ToolNow("Katana") then
                                Tp(HumRSelf, HumRSai.CFrame + HumRSai.CFrame.RightVector*-20);
                                Functions:ToolActive("Katana");
                            end;
                        end;
                    end);
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C2@Cook", function()
            if Chapter ~= "B2C1" then
                CoruTask.Close("Cook");
            end;
            
            local matches = {};
            local selected = nil;
            local selectedObj = nil;

            local GetFromCook = Functions.GetFromCook;
            local PlaceCoun = Functions.PlaceCoun;
            local ToStove = Functions.ToStove;
            local TurnInFood = Functions.TurnInFood;
            
            while true do
                if not B2C2Con.Cook.AutoCook then
                    CoruTask.Close("Cook");
                end; if not PSG.CookingUI.Timer.Visible then
                    twait(0.1); continue;
                end; if not ScriptCache.BarrierCook then
                    local Folder = Functions:B2C1Get("Workspace.Section3.Build2");
                    if not Folder then twait(0.1); continue; end;
                    local CHs = GetChildren(Folder); for i=1, #CHs do
                        local v = CHs[i]; if v.Name == "Barrier" and dist(v.Position) <= 100 then
                            v:Destroy();
                        end;
                    end; ScriptCache.BarrierCook = true;
                end;

                local Orders = Functions:B2C1Get("Workspace.Section3.Cooking.Orders");
                if not Orders then twait(0.1); continue; end; local CHs = GetChildren(Orders);
                local Givers = Functions:B2C1Get("Workspace.Section3.Cooking.Givers");
                local Stoves = Functions:B2C1Get("Workspace.Section3.Cooking.Stoves.stove.Detector.ProximityPrompt");
                local Counter = Functions:B2C1Get("Workspace.Section3.Cooking.WoodenCounters.WoodenCounter");
                local ChefPrompt = Functions:B2C1Get("Workspace.Section3.Cooking.TurnInFood.Detector.ProximityPrompt");

                for i=1, #CHs do
                    local v = CHs[i]; if v.Parent then
                        tblein(matches, v.Name);
                    end;
                end; if #matches > 0 then
                    selected = math.random(1, #matches);
                    selectedObj = matches[selected];
                    matches = {};
                    if selectedObj == "Ham Stew" then
                        GetFromCook(Givers, "Pot");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Ham");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Sausage");
                        PlaceCoun(Counter);
                        PlaceCoun(Counter);
                        ToStove(Stoves); twait(10);
                        if not B2C2Con.Cook.AutoCook or CoreDestroyed then
                            continue;
                        end; GetFromCook(Givers, "Bowl");
                        PlaceCoun(Counter);
                        ToStove(Stoves);
                        PlaceCoun(Counter);
                        PlaceCoun(Counter);
                        TurnInFood(ChefPrompt);
                    elseif selectedObj == "Chicken Soup" then
                        GetFromCook(Givers, "Pot");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Chicken");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Wrapped Meat");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Cheese");
                        PlaceCoun(Counter);
                        PlaceCoun(Counter);
                        ToStove(Stoves); twait(10);
                        if not B2C2Con.Cook.AutoCook or CoreDestroyed then
                            continue;
                        end; GetFromCook(Givers, "Bowl");
                        PlaceCoun(Counter);
                        ToStove(Stoves);
                        PlaceCoun(Counter);
                        PlaceCoun(Counter);
                        TurnInFood(ChefPrompt);
                    elseif selectedObj == "Spaghetti N Eyeballs" then
                        GetFromCook(Givers, "Bowl");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Eyeball");
                        PlaceCoun(Counter);
                        GetFromCook(Givers, "Spaghetti");
                        PlaceCoun(Counter);
                        PlaceCoun(Counter);
                        TurnInFood(ChefPrompt);
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C2@Mother", function()
            if Chapter ~= "B2C2" then
                return;
            end; while true do
                if not B2C2Con.Kid["Anti Mother"] or CoreDestroyed then
                    CoruTask.Close("Mother");
                end;

                local Object = Functions:B2C1Get("Workspace.Section4.Monsters.Mother.HumanoidRootPart");
                if Object then
                    if Object.Parent.Parent then
                        if dist(Object.Position) <= 150 then
                            Tp(HumRSelf, CFr(-4334.81299, 690.94397, -2363.2771));
                        end;
                    else
                        return;
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C2@Cannon&Lazer", function()
            if Chapter ~= "B2C2" then return; end;
            local SAFEPOS = CFr(1982.58, 100, -4780.12); while true do
                if not (B2C2Con.Nagisa["Auto Get Cannon Balls"] or B2C2Con.Nagisa["Anti Nagisa Beam"]) or CoreDestroyed then
                    CoruTask.Close("B2C2@Cannon&Lazer");
                end;

                local BallGiver = Functions:B2C1Get("Workspace.Section5.BATTLESHIP.BallGivers.BallGiver.Interact.ProximityPrompt");
                local Laser = Functions:B2C1Get("Workspace.Section5.BOSS.NureMain.POISON");

                if BallGiver and Laser then
                    if B2C2Con.Nagisa["Auto Get Cannon Balls"] then
                        if PSG.BossFight.Ammo.Text == "0" and Laser.Transparency ~= 0.5 then
                            Tp(HumRSelf, BallGiver.Parent.CFrame, 0.3); for i=1, 5 do
                                fireproximityprompt(BallGiver, 1);
                            end;
                        end
                    end;
                    if B2C2Con.Nagisa["Anti Nagisa Beam"] then
                        if Laser.Transparency ~= 1 then
                            Tp(HumRSelf, SAFEPOS);
                        end;
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C2@Serpent", function()
            if Chapter ~= "B2C2" then return; end;

            local ShouldPause = false;
            local SAFEPOS = CFr(1972, 100, -4772);

            while true do
                if not B2C2Con.Nagisa["Auto Kill Nagisa Serpent"] or CoreDestroyed then
                    if Connection then
                        ShouldPause = false;
                        Connection:Disconnect();
                        Connection = nil;
                    end; CoruTask.Close("B2C2@Serpent");
                end;
                
                if Connection then twait(0.1); continue; end;
                local Object = Functions:B2C1Get("Workspace.Section5.Stage2BOSS.NureStage2.TailHitbox1");
                if not Object then twait(0.1); continue; end;
                
                Connection = H.RenderStepped:Connect(function()
                    if not selc.Parent or not HumRSelf.Parent then return; end;
                    if ShouldPause then return; end; if Object then
                        if not Functions:ToolNow("Cutlass") then
                            local Cutlass = Functions:B2C1Get("Workspace.Section5.BATTLESHIP.CutlassGiverModel.cutlass.ProximityPrompt");
                            if Cutlass and Cutlass.Enabled then
                                ShouldPause = true;
                                Tp(HumRSelf, Cutlass.Parent.CFrame, 0.3);
                                fireproximityprompt(Cutlass);
                            end;

                            if not Functions.Cutlass then
                                Functions.Cutlass = WaitForChild(BP, "Cutlass", 3);
                            end; ShouldPause = false;
                        else
                            if not FindFirstChild(Object, "TouchInterest") then
                                Tp(HumRSelf, Object.CFrame);
                                Functions:ToolActive("Cutlass");
                            else
                                Tp(HumRSelf, SAFEPOS);
                            end;
                        end;
                    end;
                end); twait(0.1);
            end;
        end);
        CoruTask.New("B2C3@Yurei", function()
            if Chapter ~= "B2C3" then return; end;

            local Yurei = nil;
            local BZONE = Vec3(3009, 17, -416);

            repeat twait(0.1); until Functions.GameMode ~= nil; if Functions.GameMode == "Normal" then
                Yurei = WaitForChild(W.Section5.Boss.MonsterFolder, "Yurei", 9e9);
            else
                Yurei = WaitForChild(W.Section5.Boss.MonsterFolder, "YureiNM", 9e9);
            end;

            while true do
                if not B2C3Con.Boss["AutoKillYurei"] or CoreDestroyed then
                    Functions:FreeCam(false);
                    if dist(BZONE) < 600 then
                        Tp(HumRSelf, CFr(BZONE), 0.3);
                    end; CoruTask.Close("B2C3@Yurei");
                end;

                if PSG.BossFight.Enabled then
                    if dist(BZONE) < 600 then
                        local Katana = FindFirstChild(BP, "Katana") or FindFirstChild(selc, "Katana");
                        if not Katana then
                            Functions:B2C3Func("Boss/Katanas");
                            continue;
                        else
                            Functions.Katana=Katana;
                            if Functions:ToolNow("Katana") then
                                Functions:FreeCam(true); ForceFloat = true;
                                Tp(HumRSelf, Yurei.Body.CFrame * CFr(0, -40, 0), 0.3);
                                Cam.CFrame = CFr(selc.Head.Position, Yurei.Body.Position);
                                Functions:ToolActive("Katana");
                            end; Functions:FreeCam(false); ForceFloat = "None";
                        end;
                    end;
                else
                    Tp(HumRSelf, CFr(BZONE), 0.3);
                end; twait(0.1);
            end;
        end);
        CoruTask.New("UNIFIED-Yen", function()
            local SpawnFolder = nil;
            
            if Chapter == "B2C2" or Chapter == "B2C3" or Chapter == "B2C4" then
                local MimicCurrencySpawns = WaitForChild(W, "MimicCurrencySpawns", 9e9);
                SpawnFolder = WaitForChild(MimicCurrencySpawns, "Yen", 9e9);
            elseif Chapter == "B3C1" then
                SpawnFolder = WaitForChild(W, "Yen", 9e9);
            else return; end;

            while true do
                if not (YenCon.ESP or YenCon.Aura or YenCon.Auto) or CoreDestroyed then
                    ESPF.Visible("Yen", false);
                    CoruTask.Close("UNIFIED-Yen");
                end; 

                local SAVEDPOS, WAS = HumRSelf.Parent and HumRSelf.CFrame, YenCon.Auto;
                local CHs = GetChildren(SpawnFolder); for i=1, #CHs do
                    local v=CHs[i]; if v.Parent then
                        local Prox = FindFirstChildOfClass(v, "ProximityPrompt");
                        if not Prox then continue; end;

                        if YenCon.Auto and Prox.Enabled then
                            Tp(HumRSelf, v.CFrame, 0.3); fireproximityprompt(Prox);
                        elseif YenCon.Aura and dist(v.Position) <= 20 then
                            fireproximityprompt(Prox);
                        end; if YenCon.ESP then
                            local ESPObject = ESPF.ESP("Yen", v, {
                                Color = BLUE;
                                Size = VEC2;
                                Text = "Yen";
                            });
                        end;
                    end;
                end; if WAS then Tp(HumRSelf, SAVEDPOS); end;
                if YenCon.ESP then ESPF.Visible("Yen", true, true); end;

                twait(0.1);
            end;
        end);
        CoruTask.New("B2C4@EnzukaiRyu", function()
            if Chapter ~= "B2C4" then return; end;

            local EnzukaiRyu = WaitForChild(W.Section4, "BossMonster", 9e9);
            EnzukaiRyu = WaitForChild(EnzukaiRyu, "EnzukaiRyu", 9e9);

            local SAFEPOS = CFr(46, 140, -2854);

            while true do
                if not B2C4Con.Enzukai["Auto Kill Enzukai-Ryu"] or CoreDestroyed then
                    ForceFloat = "None"; CoruTask.Close("B2C4@EnzukaiRyu");
                end;

                if not EnzukaiRyu or not EnzukaiRyu.Parent or PSG.S4.Health.Front.Size == DIM0010 then
                    twait(0.1);
                    continue;
                end;

                if GetAttribute(EnzukaiRyu, "State") == 0 then
                    Tp(HumRSelf, SAFEPOS);
                elseif GetAttribute(EnzukaiRyu, "Mover_StartPivot") == nil then
                    Tp(HumRSelf, SAFEPOS);
                else
                    ForceFloat = true; if PSG.S4.Frame.Visible then
                        local EnzukaiRyuPos = EnzukaiRyu.Hitbox.Position;
                        local ENZLookVector = EnzukaiRyu.Hitbox.CFrame.LookVector;
                        Tp(HumRSelf, CFr(Vec3(EnzukaiRyuPos.X, EnzukaiRyuPos.Y + 10, EnzukaiRyuPos.Z) - ENZLookVector * 100));
                        tk.spawn(function() Functions:MagicArrowHit(Functions:ToolNow("Bow"), EnzukaiRyuPos, 0.7); end);
                    else
                        local CHs = GetChildren(W.Section4.WeakPoints.Points); for i=1, #CHs do
                            local v=CHs[i]; if v.Parent then
                                local Root = FindFirstChild(v, "RootPart");
                                local Icon = Root and FindFirstChild(Root, "Icon");
                                if not Icon or not Icon.Enabled then continue; end;

                                repeat
                                    if v.Parent then
                                        local Target, Focus = nil, nil;
                                        
                                        if v.EyeA.Transparency == 0 then Target = v.HitBoxA; Focus = v.EyeA; end;
                                        if v.EyeB.Transparency == 0 then Target = v.HitBoxB; Focus = v.EyeB; end;
                                        if v.EyeC.Transparency == 0 then Target = v.HitBoxC; Focus = v.EyeC; end;
                                        if v.EyeD.Transparency == 0 then Target = v.HitBoxD; Focus = v.EyeD; end;
                                        if v.EyeE.Transparency == 0 then Target = v.HitBoxE; Focus = v.EyeE; end;

                                        if not Target then break; end;
                                        local TargetPos, UpVector = nil, nil;

                                        while Focus.Transparency == 0 and Target.Parent and B2C4Con.Enzukai["Auto Kill Enzukai-Ryu"] and not CoreDestroyed do
                                            TargetPos = Target.Position;
                                            UpVector = Target.CFrame.UpVector;
                                            Tp(HumRSelf, CFr(Vec3(TargetPos.X, 50, TargetPos.Z) + UpVector * 20));
                                            Functions:MagicArrowHit(Functions:ToolNow("Bow"), TargetPos, 0.7); twait(0.01);
                                        end;
                                    end; twait(0.1);
                                until PSG.S4.Frame.Visible or not Root.Parent or not Icon.Parent or not Icon.Enabled or CoreDestroyed or not B2C4Con.Enzukai["Auto Kill Enzukai-Ryu"]; 
                            end;
                        end;
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C4@Followers", function()
            if Chapter ~= "B2C4" then return; end;

            local self = Functions;
            
            while true do
                if not B2C4Con.Enzukai["Auto Kill Enzukai Followers"] or CoreDestroyed then
                    ForceFloat = "None"; CoruTask.Close("B2C4@Followers");
                end;

                if not PSG.S4.Frame.Visible then
                    ForceFloat = true; local CHs = GetChildren(W.Section4.WeakPoints.Points); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local Root = FindFirstChild(v, "RootPart");
                            local Icon = Root and FindFirstChild(Root, "Icon");
                            if not Icon or not Icon.Enabled then continue; end;

                            repeat
                                if v.Parent then
                                    local Target, Focus = nil, nil;
                                    
                                    if v.EyeA.Transparency == 0 then Target = v.HitBoxA; Focus = v.EyeA; end;
                                    if v.EyeB.Transparency == 0 then Target = v.HitBoxB; Focus = v.EyeB; end;
                                    if v.EyeC.Transparency == 0 then Target = v.HitBoxC; Focus = v.EyeC; end;
                                    if v.EyeD.Transparency == 0 then Target = v.HitBoxD; Focus = v.EyeD; end;
                                    if v.EyeE.Transparency == 0 then Target = v.HitBoxE; Focus = v.EyeE; end;

                                    if not Target then break; end;
                                    local TargetPos, UpVector = nil, nil;

                                    while Focus.Transparency == 0 and Target.Parent and B2C4Con.Enzukai["Auto Kill Enzukai Followers"] and not CoreDestroyed do
                                        TargetPos = Target.Position;
                                        UpVector = Target.CFrame.UpVector;
                                        Tp(HumRSelf, CFr(Vec3(TargetPos.X, 50, TargetPos.Z) + UpVector * 20));
                                        Functions:MagicArrowHit(Functions:ToolNow("Bow"), TargetPos, 0.7); twait(0.01);
                                    end;
                                end; twait(0.1);
                            until PSG.S4.Frame.Visible or not Root.Parent or not Icon.Parent or not Icon.Enabled or CoreDestroyed or not B2C4Con.Enzukai["Auto Kill Enzukai Followers"]; 
                        end;
                    end; ForceFloat = "None";
                else
                    local CHs = {self.Rin2, self.Tenome2, self.Tsukiya2}; for i=1, #CHs do
                        local v=CHs[i]; if v and v.Parent then
                            local Root = FindFirstChild(v, "HumanoidRootPart");
                            if not Root then continue; end;
                            
                            repeat
                                if GetAttribute(v, "State") == 0 then
                                    Tp(HumRSelf, Root.CFrame, 0.3);
                                    fireproximityprompt(Root.ProximityPrompt, 1);
                                else
                                    local Pos = Root.Position;
                                    Tp(HumRSelf, CFr(Vec3(Pos.X, Pos.Y, Pos.Z) + Root.CFrame.LookVector * 20));
                                    tk.spawn(function() Functions:MagicArrowHit(Functions:ToolNow("Bow"), Pos, 0.7); end);
                                end; twait(0.01);
                            until not v.Parent or not Root.Parent or not B2C4Con.Enzukai["Auto Kill Enzukai Followers"] or CoreDestroyed;
                        end;
                    end;
                end; twait(0.1);
            end;
        end);
        CoruTask.New("B2C4@EnzukaiJin", function()
            if Chapter ~= "B2C4" then return; end;

            local EnzukaiRyujin = WaitForChild(W.Section5.FinalForm, "EnzukaiRyujin", 9e9);
            local Moves = W.Section5.FinalForm.Moves;
            local SAFEPOS = CFr(53.280338287353516, 5.957849025726318, -0.8933286666870117);
            
            while true do
                if not B2C4Con.Final["Auto Kill Final Boss"] or CoreDestroyed then
                    ForceFloat = "None";
                    CoruTask.Close("B2C4@EnzukaiJin");
                end;

                if not EnzukaiRyujin.Parent then
                    twait(0.1); continue;
                end;

                if GetAttribute(EnzukaiRyujin.VAnimator.Slam, "IsPlaying") == true then
                    Tp(HumRSelf, SAFEPOS);
                elseif PSG.S5.Frame.Visible then
                    ForceFloat = true; local HeadCF = EnzukaiRyujin.HeadHitBox.CFrame;
                    Tp(HumRSelf, HeadCF * CFr(-20, 0, 0));
                    tk.spawn(function() Functions:MagicArrowHit(Functions:ToolNow("Bow"), HeadCF.Position, 0.5); end);
                else
                    ForceFloat = true; local CHs = GetChildren(W.Section5.WeakPoints.Points); for i=1, #CHs do
                        local v=CHs[i]; if v.Parent then
                            local animated = FindFirstChild(v, "animated");
                            if not animated or animated.Value ~= 0 then continue; end;

                            repeat
                                if GetAttribute(EnzukaiRyujin.VAnimator.Slam, "IsPlaying") == true then
                                    Tp(HumRSelf, SAFEPOS);
                                elseif v.Parent then
                                    local Target, Focus = nil, nil;
                                    
                                    if v.EyeA.Transparency == 0 then Target = v.HitBoxA; Focus = v.EyeA; end;
                                    if v.EyeB.Transparency == 0 then Target = v.HitBoxB; Focus = v.EyeB; end;
                                    if v.EyeC.Transparency == 0 then Target = v.HitBoxC; Focus = v.EyeC; end;
                                    if v.EyeD.Transparency == 0 then Target = v.HitBoxD; Focus = v.EyeD; end;
                                    if v.EyeE.Transparency == 0 then Target = v.HitBoxE; Focus = v.EyeE; end;

                                    if not Target then break; end;
                                    local TargetPos, UpVector, h = nil, nil, 50;

                                    while Focus.Transparency == 0 and animated.Parent and animated.Value == 0 and Target.Parent and B2C4Con.Final["Auto Kill Final Boss"] and not CoreDestroyed and GetAttribute(EnzukaiRyujin.VAnimator.Slam, "IsPlaying") ~= true do
                                        TargetPos = Target.Position;
                                        UpVector = Target.CFrame.UpVector;
                                        h = if GetAttribute(Moves.EyeballLaser.Eyeball, "Active") then 80 else 50;
                                        Tp(HumRSelf, CFr(Vec3(TargetPos.X, TargetPos.Y + h, TargetPos.Z) + UpVector * 20));
                                        Functions:MagicArrowHit(Functions:ToolNow("Bow"), TargetPos, 0.7); twait(0.01);
                                    end;
                                end; twait(0.1);
                            until PSG.S5.Frame.Visible or not animated.Parent or animated.Value ~= 0 or CoreDestroyed or not B2C4Con.Final["Auto Kill Final Boss"]; 
                        end;
                    end; ForceFloat = "None"; Tp(HumRSelf, SAFEPOS);
                end; twait(0.1);
            end;
        end);
        CoruTask.New("NMCS@Main", function()
            if Chapter ~= "NMCS" then
                return;
            end; while true do
                if not (NMCSCon.AutoClowns or NMCSCon.AutoHammer or NMCSCon.AutoStatue or NMCSCon.AutoBoss) or CoreDestroyed then
                    CoruTask.Close("NMCS@Main");
                end;

                local Section1 = FindFirstChild(W, "Section1");
                local Section2 = FindFirstChild(W, "Section2");
                local Section3 = FindFirstChild(W, "Section3");

                if Section1 then
                    if NMCSCon.AutoClowns then
                        local Clowns = Section1.Games.WhackAClown.Clowns:QueryDescendants(
                            ">#Clown"
                        ); Functions:NMCSFunc("1/Clowns", Clowns);
                    end;
                    if NMCSCon.AutoHammer then
                        Functions:NMCSFunc("1/Hammer");
                    end;
                end;

                if Section2 then
                    if NMCSCon.AutoStatue then
                        Functions:NMCSFunc("2/Statue");
                    end;
                end;

                if Section3 then
                    if NMCSCon.AutoBoss then
                        Functions:NMCSFunc("3/Boss");
                    end;
                end;

                twait(0.1);
            end;
        end);

        local LSecureUI = function()
            local WindUI = WindLib();
            local Window = WindUI:CreateWindow({
                Title = "The Mimic",
                Folder = "TTJYStudio",
                Transparent = true,
                Theme = "Dark",
                Acrylic = LoaderSettings.AllowAcrylicBlur,
                SideBarWidth = 200,
                HasOutline = true,
                NewElements = true,
                OpenButton = {
                    Title = "TTJY Hub",
                    CornerRadius = UDim.new(1,0),
                    StrokeThickness = 3,
                    Enabled = true,
                    Draggable = true,
                    OnlyMobile = false,
                    Color = ColorSequence.new(Col3.fromHex("#30FF6A"), Col3.fromHex("#e7ff2f"))
                }, Topbar = {
                    Height = 44,
                    ButtonsType = "Mac",
                },
            });
            local Tabs = {}; Tabs = {
                Welcome = Window:Tab({ Title = "Welcome", Icon = "smile" }),
                Client = LoaderSettings.AllowClientTab and Window:Tab({ Title = "Client", Icon = "user" }),
                Yen = if ScriptData.AutoData.YenTab then Window:Tab({ Title = "Yen", Icon = "coins" }) else false,
                
                Div1 = Window:Divider(),
                Placeholder = if ScriptData.AutoData.PlaceholderTab then Window:Tab({ Title = "Information", Icon = "star" }) else false,
                NMCS = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackNMCS),
                Ken = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackKen),
                Jigoku = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackJigoku),
                Egao = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackEgao),
                B1C1 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB1C1),
                B1C2 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB1C2),
                B1C3 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB1C3),
                B1C4 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB1C4),
                B2C1 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB2C1),
                B2C2 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB2C2),
                B2C3 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB2C3),
                B2C4 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB2C4),
                B3C1 = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackB3C1),
                WitchTrial = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackWitchTrial),
                HalloweenTrial = Windy:CreateDynamic(Window, Tabs, ScriptData.AutoData.PackHalloweenTrial),
                Section = Windy:CreateDynamic(Window, Tabs, Functions:PairingSections(ScriptData.Sections)),

                ExtraDiv = Window:Divider(),
                AddOn = LoaderSettings.AllowAddOn and Window:Tab({ Title = "AddOn", Icon = "box" }),
                Themes = LoaderSettings.AllowThemesTab and Window:Tab({ Title = "Themes", Icon = "palette" }),
                Core = Window:Tab({ Title = "Core Settings", Icon = "settings" }),
            }; IntroLib.Init(WindUI, Tabs.Welcome); IntroLib:Tutorial(WindUI);
            Windy:CreateComponent(Tabs.Client, ScriptData.AutoData.ClientTab, "Client");

            Windy:CreateComponent(Tabs.Placeholder, ScriptData.AutoData.PlaceholderTab, "IGNORE");
            Windy:CreateComponent(Tabs.Yen, ScriptData.AutoData.YenTab, "Yen");

            Windy:CreateComponent(Tabs.Core, CorePackage());

            Window:SelectTab(1); Window:OnDestroy(function()
                CoreDestroyed = true;
                PromptPackage.UpdateState(true);
            end);

            Window:SetToggleKey((LoaderSettings.UIKeybind and Enum.KeyCode[LoaderSettings.UIKeybind]) or Enum.KeyCode["RightShift"]);
            ScriptCache.WindUI = WindUI; ScriptCache.Window = Window;
        end; local LSecureLoad = function(AUTH_KEY)
            local OneRunCallMain, OneRunErrorMain = pcall(function()
                CoreDestroyed = false;
                PromptPackage.UpdateState(false);
                GG.ESPF_ChangeMode = ESPF.Method;
                ClientCon.WalkSpeed = HumSelf and HumSelf.WalkSpeed or 16;
                ClientCon.JumpPower = HumSelf and HumSelf.JumpPower or 50;

                GG.Configs = Config;
                LSecureUI();

                tk.spawn(function()
                    while not CoreDestroyed do
                        if B1C4Con.Map4.AutoKillSama then
                            CoruTask.Handle("B1C4@Sama");
                        end;
                        if B1C4Con.Map4.AutoKillSaigomo then
                            CoruTask.Handle("B1C4@Saigomo");
                        end;
                        if Chapter == "B2C2" then
                            if B2C2Con.Cook.AutoCook then
                                CoruTask.Handle("B2C2@Cook");
                            end;
                            if B2C2Con.Kid["Anti Mother"] then
                                CoruTask.Handle("B2C2@Mother");
                            end;
                            if B2C2Con.Nagisa["Auto Get Cannon Balls"] or B2C2Con.Nagisa["Anti Nagisa Beam"] then
                                CoruTask.Handle("B2C2@Cannon&Lazer");
                            end;
                            if B2C2Con.Nagisa["Auto Kill Nagisa Serpent"] then
                                CoruTask.Handle("B2C2@Serpent");
                            end;
                            if B2C3Con.Boss["AutoKillYurei"] then
                                CoruTask.Handle("B2C3@Yurei");
                            end;
                        end;
                        if Chapter == "B2C4" then
                            if B2C4Con.Enzukai["Auto Kill Enzukai-Ryu"] then
                                CoruTask.Handle("B2C4@EnzukaiRyu");
                            end;
                            if B2C4Con.Enzukai["Auto Kill Enzukai Followers"] then
                                CoruTask.Handle("B2C4@Followers");
                            end;
                            if B2C4Con.Final["Auto Kill Final Boss"] then
                                CoruTask.Handle("B2C4@EnzukaiJin");
                            end;
                        end;
                        if Chapter == "B3C1" then
                            if B3C1Con.IJO.ValvesAura then
                                CoruTask.Handle("B3C1@IJO");
                            end;
                        end;
                        if Chapter == "NMCS" then
                            if NMCSCon.AutoClowns or NMCSCon.AutoHammer or NMCSCon.AutoStatue or NMCSCon.AutoBoss then
                                CoruTask.Handle("NMCS@Main");
                            end;
                        end;
                        if YenCon.ESP or YenCon.Aura or YenCon.Auto then
                            CoruTask.Handle("UNIFIED-Yen");
                        end;
                        twait(0.1);
                    end;
                end);

                CoreConnection[1] = H.Stepped:Connect(function()
                    if CoreDestroyed and CoreConnection[1] then
                        CoreConnection[1]:Disconnect(); CoreConnection[1] = nil;
                        if CoreDestroyed and CoreConnection[3] then
                            CoreConnection[3]:Disconnect(); CoreConnection[3] = nil;
                        end; return;
                    end;

                    ClientPackage.UpdatePosition(ClientCon.Float, ForceFloat, HumRSelf);
                    ClientPackage.Noclip(ClientCon.Noclip, selc.Parent and GetDescendants(selc));
                    ClientPackage.Brightness(ClientCon["Full Bright"]);
                    ClientPackage.SetJumpPower(ClientCon["Enable JumpPower"], ClientCon.JumpPower, HumSelf);

                    if ClientCon.AutoFreeYourself then
                        Functions:FreeYourself();
                    end;

                    if Config.Egao.AutoLook then
                        Functions.EgaoFunc("AutoLook");
                    end;
                end);
                CoreConnection[2] = H.Heartbeat:Connect(function(delta)
                    if CoreDestroyed and CoreConnection[2] then
                        CoreConnection[2]:Disconnect(); CoreConnection[2] = nil;
                        return;
                    end;

                    if ClientCon["Enable TeleportWalk"] and selc.Parent and HumSelf.Parent and HumSelf.MoveDirection.Magnitude > 0 then
                        selc:TranslateBy(HumSelf.MoveDirection * ClientCon["TeleportWalk Speed"] * delta * 10);
                    end;
                end);
                CoreConnection[3] = selff.CharacterAdded:Connect(function(char)
                    selc = char; BP = selff.Backpack;
                    HumSelf = WaitForChild(char, "Humanoid", 9e9);
                    HumRSelf = WaitForChild(char, "HumanoidRootPart", 9e9);
                    Functions:GameValidate(); if Chapter ~= "B3C1" then
                        ClientPackage:WalkSpeedC(HumSelf);
                    end;
                end);
                CoreConnection[4] = H.RenderStepped:Connect(function()
                    if not GG.ESPObjects or LoaderSettings.ESPMode ~= "2D" then return; end;
                    for _, TargetClass in pairs(GG.ESPObjects) do
                        for _, Data in pairs(TargetClass) do
                            if not Data.Visualize then continue; end;
                            Data:Visualize(Cam);
                        end;
                    end;
                end);
                CoreConnection[5] = PropChangeSignal(Cam, "CFrame"):Connect(function()
                    if CoreDestroyed and CoreConnection[5] then
                        CoreConnection[5]:Disconnect(); CoreConnection[5] = nil;
                        return;
                    end;

                    if CAMERAOBJECT.Parent then
                        Cam.CFrame = CFr(Cam.CFrame.Position, CAMERAOBJECT.Position);
                    end;
                end);
                
                if selff.Character then
                    selc = selff.Character; BP = selff.Backpack;
                    HumSelf = WaitForChild(selc, "Humanoid", 9e9);
                    HumRSelf = WaitForChild(selc, "HumanoidRootPart", 9e9);
                    Functions:GameValidate(); if Chapter ~= "B3C1" then
                        ClientPackage:WalkSpeedC(HumSelf);
                    end;
                end;

                if not CoruTask.Intialized then
                    CoruTask.Init(WindUI);
                    CoruTask.Intialized = true;

                    CommonF.Init(GetService(game, "VirtualInputManager"));

                    GameAI = FindFirstChild(W, "GameAI");
                    GameAI2 = FindFirstChild(W, "GameAI2");

                    DownloadPackage.Signal:Connect(function(name, value)
                        if name == "Paintings" then
                            Functions.Paints = value.Paints;
                            Functions.PaintPoses = value.Poses;
                        end; WindUI:Notify({
                            Title = "<font color='rgb(0,255,0)'>Installer [IMPORTANT]</font>",
                            Content = "Download completed: "..name,
                            Icon = "circle-alert",
                            Duration = 11,
                        });
                    end);

                    if Chapter == "B2C4" then
                        if DownloadPackage.Download(true, "Paintings") then
                            DownloadPackage.Download(false, "Paintings");
                        end; 
                    end;

                    tk.delay(3, function()
                        if QUEUE_INFO.Jigoku then
                            Functions:JigokuFunc("AutoFind");
                        elseif QUEUE_INFO.Egao then
                            Functions.EgaoFunc("AutoFind");
                        end;
                    end);

                    GG.DownloadHandler = DownloadPackage;
                end;
            end); if OneRunCallMain then
                return true, GG.LoadingSignal:Fire(100);
            end; return false, warn(OneRunErrorMain);
        end; GG.LSecureLoad = LSecureLoad; return LSecureLoad;
    end;
};
