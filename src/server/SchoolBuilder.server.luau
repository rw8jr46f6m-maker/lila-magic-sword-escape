-- Play-mode school prototype: seven floors plus rooftop, accessible stairs.
-- Fictional proportions; refine against user-supplied school photos later.
local W=game:GetService("Workspace")
local old=W:FindFirstChild("LilaSchoolBlockout");if old then old:Destroy() end
local m=Instance.new("Model");m.Name="LilaSchoolBlockout";m.Parent=W
local function p(n,s,pos,c,mat,trans,collide)
 local q=Instance.new("Part");q.Name=n;q.Size=s;q.Position=pos;q.Anchored=true;q.Color=c
 q.Material=mat or Enum.Material.Concrete;q.Transparency=trans or 0
 if collide==false then q.CanCollide=false end
 q.Parent=m;return q
end
local cream=Color3.fromRGB(222,218,204)
local floorColor=Color3.fromRGB(184,184,177)
local blue=Color3.fromRGB(95,151,172)
local steel=Color3.fromRGB(91,101,113)
local H=14
local labels={
 "1F Cafeteria / Rear Passage",
 "2F Health Practice / Piano",
 "3F Practice Rooms",
 "4F Broadcast / Faculty / Studios / Offices",
 "5F First Year / Library / Computers",
 "6F Second Year / Dance / Restroom",
 "7F Third Year / Music / Acting"
}
local function sign(name,pos,message)
 local q=p(name,Vector3.new(16,4,.5),pos,Color3.fromRGB(42,64,86),Enum.Material.SmoothPlastic)
 local g=Instance.new("SurfaceGui");g.Face=Enum.NormalId.Front;g.Parent=q
 local t=Instance.new("TextLabel");t.Size=UDim2.fromScale(1,1);t.BackgroundTransparency=1;t.Text=message;t.TextScaled=true;t.TextColor3=Color3.new(1,1,1);t.Parent=g
end
p("Ground",Vector3.new(250,1,190),Vector3.new(0,-2,-30),Color3.fromRGB(103,137,93),Enum.Material.Grass)
-- Building width 120, depth 52. Stairwell is x=-59..-39; floor slabs leave stairwell open.
for level=0,6 do
 local y=level*H
 p("MainFloor_"..level,Vector3.new(100,1,52),Vector3.new(10,y,0),floorColor)
 p("StairSideFloor_"..level,Vector3.new(20,1,8),Vector3.new(-50,y,(level%2==0 and -22 or 22)),floorColor)
 -- front wall has an opening at the stairwell entrance on the ground floor
 if level==0 then
  p("FrontWallMain",Vector3.new(100,12,1),Vector3.new(10,y+7,-26),cream)
 else
  p("FrontWall_"..level,Vector3.new(120,12,1),Vector3.new(0,y+7,-26),cream)
 end
 p("RearWall_"..level,Vector3.new(120,12,1),Vector3.new(0,y+7,26),cream)
 p("RightWall_"..level,Vector3.new(1,12,52),Vector3.new(60,y+7,0),cream)
 p("StairOuterWall_"..level,Vector3.new(1,12,52),Vector3.new(-60,y+7,0),cream)
 -- stairwell opens into the main floor at each level, without an internal wall
 for x=-25,45,14 do
  p("FrontWindow_"..level.."_"..x,Vector3.new(8,5,.2),Vector3.new(x,y+8,-26.7),blue,Enum.Material.Glass,.2,false)
 end
 sign("FloorSign_"..level,Vector3.new(-29,y+8,-25.3),labels[level+1])
 -- room divisions are short partitions so paths stay open
 if level>0 then
  for x=-12,38,25 do
   p("RoomPartition_"..level.."_"..x,Vector3.new(.6,9,15),Vector3.new(x,y+5,17),cream)
  end
 end
end
-- Stairs climb 14 studs in 14 steps, alternating direction by floor.
-- Each step is a solid anchored platform; top of step k is level+ k.
for level=0,6 do
 local base=level*H
 local reverse=level%2==1
 for k=1,14 do
  local z=(reverse and 23-(k-.5)*(46/14) or -23+(k-.5)*(46/14))
  p("Stair_"..level.."_"..k,Vector3.new(15,k,46/14+.12),Vector3.new(-50,base+k/2,z),Color3.fromRGB(158,165,174))
 end
 -- bridge from stair landing to main slab at floor above
 local endZ=(reverse and -22 or 22)
 p("LandingBridge_"..level,Vector3.new(11,1,8),Vector3.new(-39.5,base+H,endZ),floorColor)
end
p("RoofDeck",Vector3.new(100,1,52),Vector3.new(10,7*H,0),steel)
p("RoofStairLanding",Vector3.new(20,1,8),Vector3.new(-50,7*H,22),steel)
for _,z in ipairs({-26,26}) do p("RoofRail_"..z,Vector3.new(120,4,.7),Vector3.new(0,7*H+2,z),steel,Enum.Material.Metal,.35) end
for _,x in ipairs({-60,60}) do p("RoofRailSide_"..x,Vector3.new(.7,4,52),Vector3.new(x,7*H+2,0),steel,Enum.Material.Metal,.35) end
-- Exterior terrace and rear passage.
p("SideTerrace",Vector3.new(14,1,65),Vector3.new(67,0,0),floorColor)
p("TerraceRailing",Vector3.new(.5,4,65),Vector3.new(74,2,0),steel,Enum.Material.Metal,.3)
p("RearOutsidePassage",Vector3.new(120,1,10),Vector3.new(0,0,32),floorColor)
-- rear hillside, safely away from walkable stairwell
for i=1,5 do
 p("NamsanHill_"..i,Vector3.new(170,12,16),Vector3.new(0,i*5-6,-60-i*16),Color3.fromRGB(80,125,72),Enum.Material.Grass)
end
-- stylized tower silhouette on hill (not to scale)
p("NamsanTowerBase",Vector3.new(9,65,9),Vector3.new(0,62,-140),Color3.fromRGB(207,208,211),Enum.Material.Metal)
p("NamsanTowerDeck",Vector3.new(26,9,26),Vector3.new(0,95,-140),Color3.fromRGB(95,132,158),Enum.Material.Metal)
p("NamsanTowerAntenna",Vector3.new(2,38,2),Vector3.new(0,118,-140),Color3.fromRGB(220,220,220),Enum.Material.Metal)
-- Move the default spawn out of the old walled-in origin.
local existing=W:FindFirstChild("SpawnLocation")
if existing and existing:IsA("SpawnLocation") then existing.Enabled=false end
local spawn=Instance.new("SpawnLocation")
spawn.Name="SchoolSpawn";spawn.Size=Vector3.new(8,1,8);spawn.Position=Vector3.new(-50,1,-41)
spawn.Anchored=true;spawn.Neutral=true;spawn.Parent=m
print("Lila school: seven floors, rooftop and stairs built")
