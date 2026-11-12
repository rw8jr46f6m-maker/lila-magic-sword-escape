-- Myeongdong-inspired fictional street blockout. Not a geographically accurate map.
local Workspace=game:GetService("Workspace")
local old=Workspace:FindFirstChild("MyeongdongStreet")
if old then old:Destroy() end
local model=Instance.new("Model")
model.Name="MyeongdongStreet"
model.Parent=Workspace
local function block(name,size,pos,color,material)
 local p=Instance.new("Part")
 p.Name=name;p.Size=size;p.Position=pos;p.Anchored=true
 p.Color=color;p.Material=material or Enum.Material.Concrete
 p.Parent=model;return p
end
local asphalt=Color3.fromRGB(58,62,67)
local stone=Color3.fromRGB(159,158,151)
local palette={Color3.fromRGB(215,208,193),Color3.fromRGB(176,188,195),Color3.fromRGB(221,200,190),Color3.fromRGB(193,201,182)}
-- School prototype spans x +/-60 and z +/-26. Street starts beyond its +z facade.
block("StreetGround",Vector3.new(230,1,290),Vector3.new(0,-1,180),stone)
block("PedestrianMainStreet",Vector3.new(42,.2,235),Vector3.new(0,-.35,185),Color3.fromRGB(181,172,163))
block("Road",Vector3.new(230,.2,35),Vector3.new(0,-.25,65),asphalt,Enum.Material.Asphalt)
for i=-4,4 do
 block("Crosswalk_"..i,Vector3.new(5,.05,2),Vector3.new(i*7,-.12,65),Color3.fromRGB(245,244,236),Enum.Material.SmoothPlastic)
end
for side=-1,1,2 do
 for i=1,7 do
  local z=93+(i-1)*31
  local x=side*42
  local h=25+((i*7)%4)*8
  block("ShopBuilding_"..side.."_"..i,Vector3.new(31,h,27),Vector3.new(x,h/2,z),palette[(i%#palette)+1])
  block("StoreFront_"..side.."_"..i,Vector3.new(28,9,1),Vector3.new(x,5,z-14),Color3.fromRGB(55,80,92),Enum.Material.Glass)
  local sign=block("Sign_"..side.."_"..i,Vector3.new(25,4,1.2),Vector3.new(x,11,z-14.8),Color3.fromRGB(40+i*12,68,94),Enum.Material.SmoothPlastic)
  local gui=Instance.new("SurfaceGui");gui.Face=Enum.NormalId.Front;gui.Parent=sign
  local txt=Instance.new("TextLabel");txt.Size=UDim2.fromScale(1,1);txt.BackgroundTransparency=1;txt.Text="MYEONGDONG "..i;txt.TextScaled=true;txt.TextColor3=Color3.new(1,1,1);txt.Parent=gui
  for floor=1,math.floor((h-12)/9) do
   block("UpperWindow_"..side.."_"..i.."_"..floor,Vector3.new(16,4,.4),Vector3.new(x,13+floor*8,z-14),Color3.fromRGB(83,121,141),Enum.Material.Glass)
  end
  block("LampPost_"..side.."_"..i,Vector3.new(1,12,1),Vector3.new(side*21,6,z),Color3.fromRGB(55,55,60),Enum.Material.Metal)
  block("LampHead_"..side.."_"..i,Vector3.new(3,1,3),Vector3.new(side*21,12,z),Color3.fromRGB(255,227,166),Enum.Material.Neon)
 end
end
for i=1,6 do
 local z=103+i*28
 block("FoodCart_"..i,Vector3.new(6,4,4),Vector3.new((i%2==0 and 13 or -13),2,z),Color3.fromRGB(185,69,62))
 block("FoodCartRoof_"..i,Vector3.new(8,1,6),Vector3.new((i%2==0 and 13 or -13),5,z),Color3.fromRGB(239,196,93))
end
print("Myeongdong-inspired street blockout generated")
