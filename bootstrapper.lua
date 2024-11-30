for i,v in game.CoreGui:GetChildren() do
    if v.Name == "AkaliNotif" then v:Destroy() end
end
local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;
local function Log(msg: String) 
   Notify({
        Description = msg;
        Title = "WhySoSirius";
        Duration = 2.2;
});
end
if gethui():FindFirstChild("Sirius") then
    Log("NOTICE: You are attempting to run Sirius again. This WILL cause performance issues.")
    wait(4)
end
local tweenService = game:GetService("TweenService")

Log("WhySoSirius // V0.0.1 Alpha // Made by tocat.")
Log("Creating needed directories...")
makefolder("WhySoSirius")
makefolder("WhySoSirius/Plugins")
makefolder("WhySoSirius/Logs")
Log("Initializing Sirius...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/bakersrule2020/WhySoSirius/refs/heads/request/source.lua"), "WSS::MainSiriusProc")()
wait(2)
Log("Loading WhySoSirius...")
print("Adding WhySoSirius settings category...")
local SettingsShortHand = gethui().Sirius.Settings
FakePage = SettingsShortHand.SettingLists:WaitForChild("Template"):Clone()
FakePage.Name = "WSSPlugins"
FakePage.Parent = SettingsShortHand.SettingLists
FakePage.Visible = true
FakeSettings = SettingsShortHand.SettingTypes:WaitForChild("Template"):Clone()
FakeSettings.Name = "WSSPlugins"
FakeSettings.LayoutOrder = 1
FakeSettings.Parent = gethui().Sirius.Settings.SettingTypes
FakeSettings.Title.Text = "WHYSOSIRIUS"
FakeSettings.UIStroke.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.0470588, 0.0470588, 0.0470588)),ColorSequenceKeypoint.new(1, Color3.fromRGB(83, 0, 173))})
FakeSettings.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.0470588, 0.0470588, 0.0470588)),ColorSequenceKeypoint.new(1, Color3.fromRGB(83, 0, 173))})
FakeSettings.Interact.MouseButton1Click:Connect(function()
    if SettingsShortHand.SettingLists:FindFirstChild("WSSPlugins") then

				SettingsShortHand.UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.0470588, 0.0470588, 0.0470588)),ColorSequenceKeypoint.new(1, Color3.fromRGB(83, 0, 173))})
                for i,v in FakePage:GetChildren() do
                    if v:IsA("Frame") then 
                        v.Visible = false
                    end
                end
                for i,v in FakePage:GetChildren() do
                    if string.find(v.Name, "WSS") then
                        v.Visible = true
                    end
                end
                SettingsShortHand.SettingTypes.Visible = false
				SettingsShortHand.SettingLists.Visible = true
				SettingsShortHand.SettingLists.UIPageLayout:JumpTo(SettingsShortHand.SettingLists["WSSPlugins"])
				SettingsShortHand.Subtitle.Text =  "Manage your plugins, and access plugin-made settings."
				SettingsShortHand.Back.Visible = true
				SettingsShortHand.Title.Text = "WhySoSirius - Made by tocat."

				local gradientRotation = math.random(78, 95)
				SettingsShortHand.UIGradient.Rotation = gradientRotation
				tweenService:Create(SettingsShortHand.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Offset = Vector2.new(0, 0.65)}):Play()
				tweenService:Create(SettingsShortHand.Back, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
				tweenService:Create(SettingsShortHand.Back, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.041, 0, 0.052, 0)}):Play()
				tweenService:Create(SettingsShortHand.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.091, 0, 0.057, 0)}):Play()

    else
        Log("An error occured while loading the settings category.")
        SettingsShortHand.SettingTypes.Visible = true
		SettingsShortHand.SettingLists.Visible = false
    end
end)

local function MakeNewButton(label, callback) 
    local object = FakePage:WaitForChild("ButtonTemplate"):Clone()
  
    object.Parent = FakePage
    object.Name = "WSSButton"
    object.Title.Text = label
    object.Description.Text = "This button was added by WhySoSirius, likely by a plugin. Be cautious if this isnt in the WSS settings!"
    object.Description.Visible = false
    object.Note.Text = "WSS Button (tap to interact)"
        object.MouseEnter:Connect(function()
						objectTouching = true
						tweenService:Create(object.UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.45}):Play()
						tweenService:Create(object, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.83}):Play()
					end)
        object.MouseLeave:Connect(function()
						objectTouching = false
						tweenService:Create(object.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.6}):Play()
						tweenService:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.9}):Play()
					end)
        if object:FindFirstChild('Interact') then
						object.Interact.MouseButton1Click:Connect(function()
                         callback()
							tweenService:Create(object.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1}):Play()
							tweenService:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.8}):Play()
							task.wait(0.1)
							if objectTouching then
								tweenService:Create(object.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.45}):Play()
								tweenService:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.83}):Play()
							else
								tweenService:Create(object.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.6}):Play()
								tweenService:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.9}):Play()
							end
                           
						end)
					end
    object.Visible = true
    return object --Just in case if you want to do any changes post-creation.
end




FakeSettings.Visible = true
FakeSettings.MouseEnter:Connect(function()
			tweenService:Create(FakeSettings.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			tweenService:Create(FakeSettings.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.4)}):Play()
			tweenService:Create(FakeSettings.UIStroke.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.2)}):Play()
			tweenService:Create(FakeSettings.Shadow.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.2)}):Play()
		end)

FakeSettings.MouseLeave:Connect(function()
			tweenService:Create(FakeSettings.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
			tweenService:Create(FakeSettings.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.65)}):Play()
			tweenService:Create(FakeSettings.UIStroke.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.4)}):Play()
			tweenService:Create(FakeSettings.Shadow.UIGradient, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Offset = Vector2.new(0, 0.4)}):Play()
end)

ConsoleViewer = SettingsShortHand.SettingLists:WaitForChild("Template"):Clone()
ConsoleViewer.Parent = SettingsShortHand.SettingLists
ConsoleViewer.Name = "WhySSConsole"
ConsoleViewer.UIListLayout.Padding = UDim.new(0,0)
for i,v in ipairs(ConsoleViewer:GetChildren()) do
    for i,v in ipairs(ConsoleViewer:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
end
local function LazyMakeSubmenu(name)
    local sub = SettingsShortHand.SettingLists:WaitForChild("Template"):Clone()
    sub.Parent = SettingsShortHand.SettingLists
    sub.Name = name
    for i,v in ipairs(sub:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    return sub
end
function ConsoleLog(msg: String, FromWSS: bool)
    local function ObtainString()
        if FromWSS then return "[WSS]: " .. msg else return msg end
    end
    local loglabel = Instance.new("TextLabel")
    loglabel.Parent = ConsoleViewer
    loglabel.Text = DateTime.now():FormatLocalTime("LTS", "en-us") .. " | " .. ObtainString() 
    loglabel.BackgroundTransparency = 1
    loglabel.Font = Enum.Font.Code
    loglabel.TextColor3 = Color3.fromRGB(255,255,255)
    loglabel.TextWrapped = true
    loglabel.ZIndex = ConsoleViewer.ZIndex + 1
    loglabel.Size = UDim2.new(1,0,0,12)
    loglabel.TextSize = 12
    loglabel.TextXAlignment = Enum.TextXAlignment.Left
    loglabel.TextYAlignment = Enum.TextYAlignment.Top 
end
local ManagePlugins = LazyMakeSubmenu("ManagePlugins")
for i,v in ipairs(listfiles("WhySoSirius/Plugins")) do
    local newbutton = MakeNewButton(v, function()end)
    newbutton.Note.Text = "WSS Plugin"
    newbutton.Parent = ManagePlugins
end
MakeNewButton("Open Console", function()
    SettingsShortHand.SettingLists.UIPageLayout:JumpTo(ConsoleViewer)
    SettingsShortHand.Title.Text = "WhySoSirius - Console"
    SettingsShortHand.Subtitle.Text = "The output window for your plugins."
end)
MakeNewButton("See your plugins", function()
    SettingsShortHand.SettingLists.UIPageLayout:JumpTo(ManagePlugins)
    SettingsShortHand.Title.Text = "WhySoSirius - Plugins"
    SettingsShortHand.Subtitle.Text = "All of your current plugins."
end)
ConsoleLog("WSSConsole ready.", false)



Log("WhySoSirius is ready!")   
Log("Begin plugin loading...")
local wsslib = {
    PluginLog = ConsoleLog,
    MakePage = LazyMakeSubmenu,
    MakeButton = MakeNewButton
}
local loaded = {

}
for i,v in ipairs(listfiles("WhySoSirius/Plugins")) do
    ConsoleLog("---------------")
	    ConsoleLog("File Path: " .. v)
	       success, fail =  xpcall(function() module = loadstring(readfile(v))(wsslib) end, function(err) ConsoleLog("Error loading " .. v .. "!") ConsoleLog(" Error: " .. err) end)
			if not success then
				rconsoleprint("Failed to properly register mod!")
				else
	    ConsoleLog("Mod Name: " .. module.getver()["name"].. "\n")
	    ConsoleLog("Version: " .. module.getver()["version"].. "\n")
	    ConsoleLog("Mod Author(s): " .. module.getver()["author"].. "\n")
	    ConsoleLog("---------------")
        module.onmodstarted(wsslib)
end end

print("Completed init.")
