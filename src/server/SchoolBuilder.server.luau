-- Fictional, editable school blockout; NOT a measured floor plan of Lila Art High School.
local Workspace = game:GetService("Workspace")
local old = Workspace:FindFirstChild("LilaSchoolBlockout")
if old then old:Destroy() end
local model = Instance.new("Model")
model.Name = "LilaSchoolBlockout"
model.Parent = Workspace
local function part(name,size,position,color,material,transparency)
  local p=Instance.new("Part")
  p.Name=name
  p.Anchored=true
  p.Size=size
  p.Position=position
  p.Color=color
  p.Material=material or Enum.Material.Concrete
  p.Transparency=transparency or 0
  p.Parent=model
  return p
end
local wall=Color3.fromRGB(220,221,215)
local trim=Color3.fromRGB(90,103,115)
local glass=Color3.fromRGB(78,130,151)
local width,depth,floorHeight=120,52,13
for level=0,3 do
  local y=level*floorHeight
  part("Floor_"..level,Vector3.new(width,1,depth),Vector3.new(0,y,0),Color3.fromRGB(177,177,172))
  for _,z in ipairs({-depth/2,depth/2}) do
    part("Facade_"..level,Vector3.new(width,11,1),Vector3.new(0,y+6,z),wall)
    for x=-48,48,16 do
      part("Window_"..level,Vector3.new(9,5,.25),Vector3.new(x,y+7,z+(z>0 and .65 or -.65)),glass,Enum.Material.Glass,.25)
    end
  end
  for _,x in ipairs({-width/2,width/2}) do
    part("SideWall_"..level,Vector3.new(1,11,depth),Vector3.new(x,y+6,0),wall)
  end
  for x=-40,40,20 do
    part("ClassDividerNorth_"..level,Vector3.new(.7,10,18),Vector3.new(x,y+6,-16),wall)
    part("ClassDividerSouth_"..level,Vector3.new(.7,10,18),Vector3.new(x,y+6,16),wall)
  end
end
part("Roof",Vector3.new(width+2,1,depth+2),Vector3.new(0,4*floorHeight,0),trim)
part("Ground",Vector3.new(180,1,130),Vector3.new(0,-2,0),Color3.fromRGB(92,126,83),Enum.Material.Grass)
local spawn=Instance.new("SpawnLocation")
spawn.Name="SchoolSpawn"
spawn.Size=Vector3.new(8,1,8)
spawn.Position=Vector3.new(0,1,0)
spawn.Anchored=true
spawn.Neutral=true
spawn.Parent=model
print("Lila school prototype generated")
