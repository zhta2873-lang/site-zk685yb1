-- =====================================================
-- هاكر روبلوكس V6 - إصلاح الكلبشة الحقيقية
-- تعمل على Android عبر Arceus X / Hydrogen
-- =====================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- متغيرات الكلبشة
local targetPlayer = nil
local isHandcuffed = false
local handcuffConnection = nil
local handcuffBodyPosition = nil

-- باقي المتغيرات
local isFlying = false
local isSpeedEnabled = false
local isGUIVisible = true
local isMusicPlaying = false
local flySpeed = 50
local speedValue = 40

-- =====================================================
-- 1. إنشاء الواجهة (نفس الكود السابق مع تعديل الأزرار)
-- =====================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackGUI"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false

-- الأيقونة الرئيسية
local IconButton = Instance.new("ImageButton")
IconButton.Name = "IconButton"
IconButton.Size = UDim2.new(0, 60, 0, 60)
IconButton.Position = UDim2.new(0, 10, 0, 100)
IconButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IconButton.BackgroundTransparency = 0.2
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://1234567890" -- رابط صورة شريرة
IconButton.Parent = ScreenGui

-- النافذة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- خلفية شريرة
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://1234567892" -- خلفية شريرة
BackgroundImage.ImageTransparency = 0.3
BackgroundImage.Parent = MainFrame

-- زر الإغلاق X
local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BackgroundTransparency = 0.3
CloseButton.Image = "rbxassetid://1234567893"
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
    isGUIVisible = false
end)

-- إظهار النافذة عند الضغط على الأيقونة
IconButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible == false then
        MainFrame.Visible = true
        IconButton.Visible = false
        isGUIVisible = true
        PlayMusic()
    end
end)

-- وظيفة تشغيل الموسيقى
function PlayMusic()
    if isMusicPlaying == false then
        isMusicPlaying = true
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://1234567894" -- رابط صوت قوي
        Sound.Volume = 1
        Sound.PlayOnRemove = false
        Sound.Parent = Player.Character
        Sound:Play()
        game:GetService("Debris"):AddItem(Sound, 10)
        wait(10)
        isMusicPlaying = false
    end
end

-- =====================================================
-- 2. تصميم النافذة
-- =====================================================

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ هاكر الشيطان V6 ⚡"
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- حقل إدخال اسم المستخدم
local TargetLabel = Instance.new("TextLabel")
TargetLabel.Size = UDim2.new(0.4, 0, 0, 30)
TargetLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "👤 اسم الضحية:"
TargetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetLabel.TextScaled = true
TargetLabel.Font = Enum.Font.GothamBold
TargetLabel.Parent = MainFrame

local TargetBox = Instance.new("TextBox")
TargetBox.Size = UDim2.new(0.5, 0, 0, 30)
TargetBox.Position = UDim2.new(0.45, 0, 0.15, 0)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TargetBox.BackgroundTransparency = 0.3
TargetBox.BorderSizePixel = 0
TargetBox.Text = ""
TargetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetBox.TextScaled = true
TargetBox.Font = Enum.Font.Gotham
TargetBox.PlaceholderText = "أدخل اسم المستخدم"
TargetBox.Parent = MainFrame

-- =====================================================
-- 3. زر الكلبشة المُصلح (Handcuff)
-- =====================================================

local HandcuffButton = Instance.new("TextButton")
HandcuffButton.Size = UDim2.new(0.3, 0, 0, 40)
HandcuffButton.Position = UDim2.new(0.05, 0, 0.25, 0)
HandcuffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
HandcuffButton.BackgroundTransparency = 0.3
HandcuffButton.BorderSizePixel = 0
HandcuffButton.Text = "🔒 كلبش (جديد)"
HandcuffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HandcuffButton.TextScaled = true
HandcuffButton.Font = Enum.Font.GothamBold
HandcuffButton.Parent = MainFrame

HandcuffButton.MouseButton1Click:Connect(function()
    local username = TargetBox.Text
    if username ~= "" then
        HandcuffPlayer(username)
    else
        ShowNotification("⚠️ ادخل اسم المستخدم أولاً!")
    end
end)

-- =====================================================
-- 4. زر فك الكلبشة (No SA) المُصلح
-- =====================================================

local UnhandcuffButton = Instance.new("TextButton")
UnhandcuffButton.Size = UDim2.new(0.3, 0, 0, 40)
UnhandcuffButton.Position = UDim2.new(0.4, 0, 0.25, 0)
UnhandcuffButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
UnhandcuffButton.BackgroundTransparency = 0.3
UnhandcuffButton.BorderSizePixel = 0
UnhandcuffButton.Text = "🔓 No SA"
UnhandcuffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UnhandcuffButton.TextScaled = true
UnhandcuffButton.Font = Enum.Font.GothamBold
UnhandcuffButton.Parent = MainFrame

UnhandcuffButton.MouseButton1Click:Connect(function()
    local username = TargetBox.Text
    if username ~= "" then
        UnhandcuffPlayer(username)
    else
        ShowNotification("⚠️ ادخل اسم المستخدم أولاً!")
    end
end)

-- =====================================================
-- 5. باقي الأزرار (طيران، سرعة، إيقاف)
-- =====================================================

-- زر الطيران (XXO)
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.3, 0, 0, 40)
FlyButton.Position = UDim2.new(0.05, 0, 0.38, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
FlyButton.BackgroundTransparency = 0.3
FlyButton.BorderSizePixel = 0
FlyButton.Text = "✈️ XXO (طيران)"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true
FlyButton.Font = Enum.Font.GothamBold
FlyButton.Parent = MainFrame

FlyButton.MouseButton1Click:Connect(function()
    ToggleFly()
end)

-- زر إلغاء الطيران (XXC)
local UnflyButton = Instance.new("TextButton")
UnflyButton.Size = UDim2.new(0.3, 0, 0, 40)
UnflyButton.Position = UDim2.new(0.4, 0, 0.38, 0)
UnflyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
UnflyButton.BackgroundTransparency = 0.3
UnflyButton.BorderSizePixel = 0
UnflyButton.Text = "🛑 XXC (إلغاء)"
UnflyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UnflyButton.TextScaled = true
UnflyButton.Font = Enum.Font.GothamBold
UnflyButton.Parent = MainFrame

UnflyButton.MouseButton1Click:Connect(function()
    ToggleFly(false)
end)

-- زر السرعة (JJK)
local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.3, 0, 0, 40)
SpeedButton.Position = UDim2.new(0.05, 0, 0.51, 0)
SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
SpeedButton.BackgroundTransparency = 0.3
SpeedButton.BorderSizePixel = 0
SpeedButton.Text = "⚡ JJK (سرعة 4x)"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextScaled = true
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.Parent = MainFrame

SpeedButton.MouseButton1Click:Connect(function()
    ToggleSpeed(true)
end)

-- زر إلغاء السرعة (JJH)
local UnspeedButton = Instance.new("TextButton")
UnspeedButton.Size = UDim2.new(0.3, 0, 0, 40)
UnspeedButton.Position = UDim2.new(0.4, 0, 0.51, 0)
UnspeedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
UnspeedButton.BackgroundTransparency = 0.3
UnspeedButton.BorderSizePixel = 0
UnspeedButton.Text = "⛔ JJH (إلغاء)"
UnspeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UnspeedButton.TextScaled = true
UnspeedButton.Font = Enum.Font.GothamBold
UnspeedButton.Parent = MainFrame

UnspeedButton.MouseButton1Click:Connect(function()
    ToggleSpeed(false)
end)

-- زر إيقاف الكل (67)
local StopAllButton = Instance.new("TextButton")
StopAllButton.Size = UDim2.new(0.6, 0, 0, 40)
StopAllButton.Position = UDim2.new(0.2, 0, 0.65, 0)
StopAllButton.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
StopAllButton.BackgroundTransparency = 0.3
StopAllButton.BorderSizePixel = 0
StopAllButton.Text = "💀 67 (إيقاف الكل)"
StopAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopAllButton.TextScaled = true
StopAllButton.Font = Enum.Font.GothamBold
StopAllButton.Parent = MainFrame

StopAllButton.MouseButton1Click:Connect(function()
    StopAll()
end)

-- =====================================================
-- 6. وظيفة الكلبشة الحقيقية (باستخدام BodyPosition + Loop)
-- =====================================================

function HandcuffPlayer(username)
    -- البحث عن اللاعب
    local target = Players:FindFirstChild(username)
    if not target then
        ShowNotification("❌ لم يتم العثور على " .. username)
        return
    end
    
    -- إذا كان هناك كلبشة سابقة، فكها أولاً
    if isHandcuffed then
        UnhandcuffPlayer(targetPlayer.Name)
    end
    
    local character = target.Character
    if not character then
        ShowNotification("❌ الشخصية غير موجودة!")
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then
        ShowNotification("❌ لا يمكن العثور على الجذر!")
        return
    end
    
    -- تعيين الهدف
    targetPlayer = target
    isHandcuffed = true
    
    -- 1. تجميد السرعة والقفز (بقوة)
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.PlatformStand = true -- يمنع السقوط والحركة
    
    -- 2. إنشاء BodyPosition بقوة هائلة لتثبيت المكان
    handcuffBodyPosition = Instance.new("BodyPosition")
    handcuffBodyPosition.MaxForce = Vector3.new(1e6, 1e6, 1e6) -- قوة خارقة
    handcuffBodyPosition.P = 10000 -- صلابة عالية جداً
    handcuffBodyPosition.D = 5000
    handcuffBodyPosition.Position = rootPart.Position
    handcuffBodyPosition.Parent = rootPart
    
    -- 3. حلقة تكرارية لتأكيد التجميد كل إطار (السلاح السري)
    handcuffConnection = RunService.Heartbeat:Connect(function()
        -- التأكد من أن الهدف لا يزال موجوداً
        if not targetPlayer or not targetPlayer.Character then
            UnhandcuffPlayer(targetPlayer and targetPlayer.Name or "")
            return
        end
        
        local currentChar = targetPlayer.Character
        local currentHumanoid = currentChar:FindFirstChild("Humanoid")
        local currentRoot = currentChar:FindFirstChild("HumanoidRootPart")
        
        if currentHumanoid and currentRoot then
            -- إعادة تعيين السرعة إلى صفر (بشكل قسري)
            currentHumanoid.WalkSpeed = 0
            currentHumanoid.JumpPower = 0
            currentHumanoid.PlatformStand = true
            
            -- تحديث BodyPosition إلى المكان الحالي (لن يتحرك أبداً)
            if handcuffBodyPosition then
                handcuffBodyPosition.Position = currentRoot.Position
            end
            
            -- تجميد جميع الأجزاء الفيزيائية (لضمان عدم الحركة)
            for _, part in ipairs(currentChar:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                end
            end
        end
    end)
    
    -- تغيير لون الشخصية للأحمر كدليل
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.BrickColor = BrickColor.new("Bright red")
        end
    end
    
    ShowNotification("✅ تم كلبشة " .. username .. " حقيقياً!")
end

-- =====================================================
-- 7. وظيفة فك الكلبشة (No SA) المُصلحة
-- =====================================================

function UnhandcuffPlayer(username)
    if not username or username == "" then
        -- فك الكلبشة الحالية بدون اسم
        if targetPlayer then
            username = targetPlayer.Name
        else
            return
        end
    end
    
    local target = Players:FindFirstChild(username)
    if not target and targetPlayer then
        target = targetPlayer
    end
    
    if not target then
        ShowNotification("❌ لا يوجد هدف للفك!")
        return
    end
    
    local character = target.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        -- إعادة الإعدادات الطبيعية
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            humanoid.PlatformStand = false
        end
        
        -- إزالة BodyPosition
        if handcuffBodyPosition then
            handcuffBodyPosition:Destroy()
            handcuffBodyPosition = nil
        end
        
        -- إيقاف الحلقة التكرارية
        if handcuffConnection then
            handcuffConnection:Disconnect()
            handcuffConnection = nil
        end
        
        -- إعادة الألوان
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.BrickColor = BrickColor.new("White")
                part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
            end
        end
    end
    
    isHandcuffed = false
    targetPlayer = nil
    ShowNotification("✅ تم فك كلبشة " .. username .. "!")
end

-- =====================================================
-- 8. وظيفة الطيران (نفسها)
-- =====================================================

local flyConnection = nil
local flyBodyVelocity = nil

function ToggleFly(state)
    if state == nil then state = not isFlying end
    
    if state and not isFlying then
        isFlying = true
        local character = Player.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = character.HumanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not isFlying then flyConnection:Disconnect() return end
            local moveDirection = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Vector3.new(0, 0, -flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection + Vector3.new(0, 0, flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection + Vector3.new(-flySpeed, 0, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Vector3.new(flySpeed, 0, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, flySpeed, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection + Vector3.new(0, -flySpeed, 0) end
            if moveDirection.Magnitude > 0 then moveDirection = moveDirection.Unit * flySpeed end
            flyBodyVelocity.Velocity = moveDirection
        end)
        humanoid.PlatformStand = true
        ShowNotification("✈️ تم تفعيل الطيران!")
    else
        isFlying = false
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
        local character = Player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then humanoid.PlatformStand = false end
        end
        ShowNotification("🛑 تم إلغاء الطيران!")
    end
end

-- =====================================================
-- 9. وظيفة السرعة (نفسها)
-- =====================================================

function ToggleSpeed(state)
    if state == nil then state = not isSpeedEnabled end
    local character = Player.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    if state then
        isSpeedEnabled = true
        humanoid.WalkSpeed = 64
        ShowNotification("⚡ تم تفعيل السرعة 4x!")
    else
        isSpeedEnabled = false
        humanoid.WalkSpeed = 16
        ShowNotification("⛔ تم إلغاء السرعة!")
    end
end

-- =====================================================
-- 10. وظيفة إيقاف الكل (Stop All)
-- =====================================================

function StopAll()
    if isFlying then ToggleFly(false) end
    if isSpeedEnabled then ToggleSpeed(false) end
    if isHandcuffed and targetPlayer then
        UnhandcuffPlayer(targetPlayer.Name)
    end
    ShowNotification("💀 تم إيقاف كل شيء!")
end

-- =====================================================
-- 11. وظيفة الإشعارات
-- =====================================================

function ShowNotification(message)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 40)
    notification.Position = UDim2.new(0.5, -150, 0.1, 0)
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notification.BackgroundTransparency = 0.5
    notification.BorderSizePixel = 0
    notification.Text = message
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.TextScaled = true
    notification.Font = Enum.Font.GothamBold
    notification.Parent = ScreenGui
    notification.TextTransparency = 0
    notification:TweenPosition(UDim2.new(0.5, -150, 0.15, 0), "Out", "Quad", 0.3)
    wait(2)
    notification:TweenPosition(UDim2.new(0.5, -150, 0.1, 0), "In", "Quad", 0.3)
    wait(0.3)
    notification:Destroy()
end

-- =====================================================
-- 12. اختصارات لوحة المفاتيح
-- =====================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X and input.UserInputType == Enum.UserInputType.Keyboard then
        if isGUIVisible then
            MainFrame.Visible = false
            IconButton.Visible = true
            isGUIVisible = false
        else
            MainFrame.Visible = true
            IconButton.Visible = false
            isGUIVisible = true
            PlayMusic()
        end
    end
    if input.KeyCode == Enum.KeyCode.O and UserInputService:IsKeyDown(Enum.KeyCode.X) then ToggleFly() end
    if input.KeyCode == Enum.KeyCode.C and UserInputService:IsKeyDown(Enum.KeyCode.X) then ToggleFly(false) end
    if input.KeyCode == Enum.KeyCode.K and UserInputService:IsKeyDown(Enum.KeyCode.J) then ToggleSpeed(true) end
    if input.KeyCode == Enum.KeyCode.H and UserInputService:IsKeyDown(Enum.KeyCode.J) then ToggleSpeed(false) end
    if input.KeyCode == Enum.KeyCode.Seven and UserInputService:IsKeyDown(Enum.KeyCode.Six) then StopAll() end
end)

-- =====================================================
-- 13. بداية التشغيل
-- =====================================================

ShowNotification("🔥 تم تحميل هاكر الشيطان V6!")
wait(1)
ShowNotification("👾 الكلبشة الآن حقيقية وفعالة!")
print("✅ هاكر روبلوكس V6 - الكلبشة تعمل بقوة!")
