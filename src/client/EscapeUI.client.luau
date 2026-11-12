local RS=game:GetService("ReplicatedStorage")
local Players=game:GetService("Players")
local player=Players.LocalPlayer
local remote=RS:WaitForChild("LilaStoryEvent")
local gui=Instance.new("ScreenGui")
gui.Name="LilaEscapeUI";gui.ResetOnSpawn=false;gui.Parent=player:WaitForChild("PlayerGui")
local frame=Instance.new("Frame")
frame.AnchorPoint=Vector2.new(.5,0);frame.Position=UDim2.fromScale(.5,.06)
frame.Size=UDim2.new(.86,0,0,115);frame.BackgroundColor3=Color3.fromRGB(24,29,43)
frame.BackgroundTransparency=.12;frame.Visible=false;frame.Parent=gui
local corner=Instance.new("UICorner");corner.CornerRadius=UDim.new(0,12);corner.Parent=frame
local label=Instance.new("TextLabel")
label.Size=UDim2.new(1,-24,1,-18);label.Position=UDim2.fromOffset(12,9)
label.BackgroundTransparency=1;label.TextColor3=Color3.new(1,1,1)
label.TextWrapped=true;label.TextScaled=true;label.Font=Enum.Font.GothamBold;label.Parent=frame
local serial=0
remote.OnClientEvent:Connect(function(kind,message)
 serial+=1
 local id=serial
 label.Text=message
 frame.Visible=true
 if kind=="ending" then
  frame.Size=UDim2.new(.86,0,0,190)
  frame.BackgroundColor3=Color3.fromRGB(22,93,67)
  return
 end
 frame.Size=UDim2.new(.86,0,0,115)
 task.delay(kind=="intro" and 10 or 6,function()
  if id==serial then frame.Visible=false end
 end)
end)
