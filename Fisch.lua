repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
local function httpRequest(data)
    if syn and syn.request then
        return syn.request(data)
    elseif http and http.request then
        return http.request(data)
    elseif fluxus and fluxus.request then
        return fluxus.request(data)
    elseif request then
        return request(data)
    else
        warn("❌ request")
        return nil
    end
end
pcall(function()
    local response = httpRequest({
        Url = "https://445c-1-10-219-103.ngrok-free.app/verify",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode({
            Key = getgenv().key,
            HWID = game:GetService("RbxAnalyticsService"):GetClientId()
        })
    })
    if response then
        for i = 1, 100, 4 do
            print(string.format("[Loader]: [%s%s] (%d%%) - Connecting to server..", string.rep("#", i // 4), string.rep(" ", 25 - #string.rep("#", i // 4)), i))
            wait(0.1)
        end
        local body = response.Body or response.Data or response.Content or ""
        if body and body ~= "" then
            local jsonData = game:GetService("HttpService"):JSONDecode(body)
            if jsonData and jsonData.status == "success" then
                print("[Loader]: [#########################] (100%) - Loaded successfully!")
				wait(.1)
				warn("Script Name : Fisch")
                if game:GetService("CoreGui").HUI:FindFirstChild("WindUI") then
                    game:GetService("CoreGui").HUI:FindFirstChild("WindUI"):Destory()
                end
                local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
                
                local Window = WindUI:CreateWindow({
                    Title = "Fisch Script",
                    Icon = "door-open",
                    Author = "By SunZens",
                    Folder = "CloudHub",
                    Size = UDim2.fromOffset(580, 460),
                    Transparent = true,
                    Theme = "Dark",
                    SideBarWidth = 200,
                    HasOutline = false,
                })
                
                local Tabs = {
                    ToggleTab = Window:Tab({ Title = "Functions", Icon = "toggle-left", Desc = "Switch settings on and off." }),
                    CodeTab = Window:Tab({ Title = "Code", Icon = "code", Desc = "Displays and manages code snippets." }),
                    b = Window:Divider(),
                    WindowTab = Window:Tab({ Title = "Window and File Configuration", Icon = "settings", Desc = "Manage window settings and file configurations." }),
                    CreateThemeTab = Window:Tab({ Title = "Create Theme", Icon = "palette", Desc = "Design and apply custom themes." }),
                }
                
                Window:SelectTab(1)
                
                Tabs.ToggleTab:Toggle({Title = "Auto Fishing", Default = _G.Auto_Fishing, Callback = function(Value)
                    _G.Auto_Fishing = Value
                    while _G.Auto_Fishing do wait()
                        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.Name:lower():find("rod") then
                                Equip(v.Name)
                            end
                        end
                        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                            if _G.Always_Position then
                                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui") then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                else
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").events.cast:FireServer(100,1)
                                end
                            else
                                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").events.cast:FireServer(100,1)
                            end
                        end
                    end
                end})
                
                Tabs.ToggleTab:Toggle({Title = "Auto Shake", Default = _G.Auto_Shake, Callback = function(Value)
                    _G.Auto_Shake = Value
                    while _G.Auto_Shake do wait()
                        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui") then
                            game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.shakeui.safezone:FindFirstChild("button")
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end})
                
                for i,v in pairs(game:GetService("CoreGui").HUI:GetDescendants()) do
                    if v:IsA("ScreenGui") then
                        print(v)
                    end
                end
                
                
                Tabs.ToggleTab:Toggle({Title = "Auto Reel", Default = _G.Auto_Reel, Callback = function(Value)
                    _G.Auto_Reel = Value
                    while _G.Auto_Reel do wait()
                        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
                            if v:IsA("ScreenGui") and v.Name == "reel"then
                                if v:FindFirstChild("bar") then
                                    game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100,true)
                                end
                            end
                        end
                    end
                end})
                
                Tabs.ToggleTab:Toggle({Title = "Always Position", Default = _G.Always_Position, Callback = function(Value)
                    _G.Always_Position = Value
                    if _G.Always_Position then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    end
                end})
                
                Tabs.CodeTab:Code({Title = "Auto Fishing Code", Code = [[
                while _G.Auto_Fishing do wait()
                    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name:lower():find("rod") then
                            Equip(v.Name)
                        end
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                        if _G.Always_Position then
                            if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui") then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            else
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").events.cast:FireServer(100,1)
                            end
                        else
                            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").events.cast:FireServer(100,1)
                        end
                    end
                end
                ]],})
                
                Tabs.CodeTab:Code({Title = "Autoc Shake Code", Code = [[
                while _G.Auto_Shake do wait()
                    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui") then
                        game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.shakeui.safezone:FindFirstChild("button")
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
                end
                ]],})
                
                Tabs.CodeTab:Code({Title = "Auto Reel Code", Code = [[
                while _G.Auto_Reel do wait()
                    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
                        if v:IsA("ScreenGui") and v.Name == "reel"then
                            if v:FindFirstChild("bar") then
                                game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100,true)
                            end
                        end
                    end
                end
                ]],})
                
                Tabs.CodeTab:Code({Title = "Always Position Code", Code = [[
                if _G.Always_Position then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                end
                ]],})
                
                -- [ Configuration ]
                
                local HttpService = game:GetService("HttpService")
                
                local folderPath = "WindUI"
                makefolder(folderPath)
                
                local function SaveFile(fileName, data)
                    local filePath = folderPath .. "/" .. fileName .. ".json"
                    local jsonData = HttpService:JSONEncode(data)
                    writefile(filePath, jsonData)
                end
                
                local function LoadFile(fileName)
                    local filePath = folderPath .. "/" .. fileName .. ".json"
                    if isfile(filePath) then
                        local jsonData = readfile(filePath)
                        return HttpService:JSONDecode(jsonData)
                    end
                end
                
                local function ListFiles()
                    local files = {}
                    for _, file in ipairs(listfiles(folderPath)) do
                        local fileName = file:match("([^/]+)%.json$")
                        if fileName then
                            table.insert(files, fileName)
                        end
                    end
                    return files
                end
                
                Tabs.WindowTab:Section({ Title = "Window" })
                
                local themeValues = {}
                for name, _ in pairs(WindUI:GetThemes()) do
                    table.insert(themeValues, name)
                end
                
                local themeDropdown = Tabs.WindowTab:Dropdown({Title = "Select Theme", Multi = false, AllowNone = false, Value = nil, Values = themeValues, Callback = function(theme)
                    WindUI:SetTheme(theme)
                end})
                
                themeDropdown:Select(WindUI:GetCurrentTheme())
                
                local ToggleTransparency = Tabs.WindowTab:Toggle({Title = "Toggle Window Transparency", Callback = function(e) Window:ToggleTransparency(e) end, Value = WindUI:GetTransparency()})
                
                Tabs.WindowTab:Section({ Title = "Save" })
                
                local fileNameInput = ""
                Tabs.WindowTab:Input({Title = "Write File Name", PlaceholderText = "Enter file name", Callback = function(text)
                    fileNameInput = text
                end})
                
                Tabs.WindowTab:Button({Title = "Save File", Callback = function()
                    if fileNameInput ~= "" then
                        SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
                    end
                end})
                
                Tabs.WindowTab:Section({ Title = "Load" })
                
                local filesDropdown
                local files = ListFiles()
                
                filesDropdown = Tabs.WindowTab:Dropdown({Title = "Select File", Multi = false, AllowNone = true, Values = files, Callback = function(selectedFile)
                    fileNameInput = selectedFile
                end})
                
                Tabs.WindowTab:Button({Title = "Load File", Callback = function()
                    if fileNameInput ~= "" then
                        local data = LoadFile(fileNameInput)
                        if data then
                            WindUI:Notify({Title = "File Loaded", Content = "Loaded data: " .. HttpService:JSONEncode(data), Duration = 5,})
                            if data.Transparent then 
                                Window:ToggleTransparency(data.Transparent)
                                ToggleTransparency:SetValue(data.Transparent)
                            end
                            if data.Theme then
                                WindUI:SetTheme(data.Theme)
                            end
                        end
                    end
                end})
                
                Tabs.WindowTab:Button({Title = "Overwrite File", Callback = function()
                    if fileNameInput ~= "" then
                        SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
                    end
                end})
                
                Tabs.WindowTab:Button({Title = "Refresh List", Callback = function()
                    filesDropdown:Refresh(ListFiles())
                end})
                
                local currentThemeName = WindUI:GetCurrentTheme()
                local themes = WindUI:GetThemes()
                local ThemeAccent = themes[currentThemeName].Accent
                local ThemeOutline = themes[currentThemeName].Outline
                local ThemeText = themes[currentThemeName].Text
                local ThemePlaceholderText = themes[currentThemeName].PlaceholderText
                
                function updateTheme()WindUI:AddTheme({Name = currentThemeName, Accent = ThemeAccent, Outline = ThemeOutline, Text = ThemeText, PlaceholderText = ThemePlaceholderText})
                    WindUI:SetTheme(currentThemeName)
                end
                
                local CreateInput = Tabs.CreateThemeTab:Input({Title = "Theme Name", Value = currentThemeName, Callback = function(name)
                    currentThemeName = name
                end})
                
                Tabs.CreateThemeTab:Colorpicker({Title = "Background Color", Default = Color3.fromHex(ThemeAccent), Callback = function(color)
                    ThemeAccent = color:ToHex()
                end})
                
                Tabs.CreateThemeTab:Colorpicker({Title = "Outline Color", Default = Color3.fromHex(ThemeOutline), Callback = function(color)
                    ThemeOutline = color:ToHex()
                end})
                
                Tabs.CreateThemeTab:Colorpicker({Title = "Text Color", Default = Color3.fromHex(ThemeText), Callback = function(color)
                    ThemeText = color:ToHex()
                end})
                
                Tabs.CreateThemeTab:Colorpicker({Title = "Placeholder Text Color", Default = Color3.fromHex(ThemePlaceholderText), Callback = function(color)
                    ThemePlaceholderText = color:ToHex()
                end})
                
                Tabs.CreateThemeTab:Button({Title = "Update Theme", Callback = function()
                    updateTheme()
                end})
                
                -- [ Function ]
                
                function Equip(v)
                    if game.Players.LocalPlayer.Backpack:FindFirstChild(v) then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(v))
                    end
                end
            else
                game.Players.LocalPlayer:Kick("[Zenon Hub]:Key Invalid or HWID Mismatch")
            end
        else
            game.Players.LocalPlayer:Kick("[Zenon Hub]:Unauthorized.User does not have access to this script")
        end
    else
        game.Players.LocalPlayer:Kick("[Zenon Hub]:Executor not supported")
    end
end)
