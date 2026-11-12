-- Find the business card on 7F, return to the entrance phone, call for ending.
local Players=game:GetService("Players")
local RS=game:GetService("ReplicatedStorage")
local W=game:GetService("Workspace")
local old=W:FindFirstChild("LilaEscapeObjectives");if old then old:Destroy() end
local m=Instance.new("Model");m.Name="LilaEscapeObjectives";m.Parent=W
local remote=RS:FindFirstChild("LilaStoryEvent") or Instance.new("RemoteEvent")
remote.Name="LilaStoryEvent";remote.Parent=RS
local function obj(name,size,pos,color)
 local q=Instance.new("Part");q.Name=name;q.Anchored=true;q.Size=size;q.Position=pos;q.Color=color
 q.Material=Enum.Material.Neon;q.Parent=m;return q
end
local function prompt(parent,action,object)
 local pr=Instance.new("ProximityPrompt")
 pr.ActionText=action;pr.ObjectText=object;pr.HoldDuration=.6;pr.MaxActivationDistance=12
 pr.RequiresLineOfSight=false;pr.Parent=parent;return pr
end
local card=obj("TungTungKanBusinessCard",Vector3.new(4,.3,2.5),Vector3.new(22,6*14+3,2),Color3.fromRGB(255,206,68))
local cardPedestal=obj("CardPedestal",Vector3.new(6,3,5),Vector3.new(22,6*14+1,2),Color3.fromRGB(62,63,77))
cardPedestal.Material=Enum.Material.Metal
local cardPrompt=prompt(card,"명함 줍기","퉁퉁칸의 명함")
local phone=obj("EntranceTelephone",Vector3.new(3,4,2),Vector3.new(-34,3,-38),Color3.fromRGB(71,182,236))
local phonePrompt=prompt(phone,"전화 걸기","학교 밖 공중전화")
local function setup(plr)
 plr:SetAttribute("HasTungTungKanCard",false)
 plr:SetAttribute("LilaEscaped",false)
 task.delay(3,function()
  if plr.Parent then remote:FireClient(plr,"intro","방과 후 연습을 마쳤지만 학교 문이 잠겼다. 7층에서 퉁퉁칸의 명함을 찾아 전화하자!") end
 end)
end
Players.PlayerAdded:Connect(setup)
for _,plr in ipairs(Players:GetPlayers()) do setup(plr) end
cardPrompt.Triggered:Connect(function(plr)
 if plr:GetAttribute("HasTungTungKanCard") then
  remote:FireClient(plr,"notice","이미 명함을 가지고 있어!")
  return
 end
 plr:SetAttribute("HasTungTungKanCard",true)
 remote:FireClient(plr,"card","퉁퉁칸의 명함을 찾았다! 1층 입구의 전화기로 돌아가자.")
end)
phonePrompt.Triggered:Connect(function(plr)
 if plr:GetAttribute("LilaEscaped") then return end
 if not plr:GetAttribute("HasTungTungKanCard") then
  remote:FireClient(plr,"notice","전화번호를 모른다. 7층에서 명함을 먼저 찾아야 한다.")
  return
 end
 plr:SetAttribute("LilaEscaped",true)
 remote:FireClient(plr,"ending","뚜루루... 여보세요? 퉁퉁칸입니다. 학교 정문 열어드릴게요!\n\n탈출 성공! 마지막 하교")
end)
