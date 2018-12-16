
_fmt = string.format

class 'CDismantleMgr'
function CDismantleMgr:__init(app)
  self.app = app
  --self.font = app.DirectX:CreateFont(20, 15, 700, false, "Arial")  
  self.font = app.DirectX:CreateFont(13, 6, 400, false, "Arial")
  self.enabled = false
  self.time_last = 0
  self.interval = 2000
  print("CDismantleMgr") --debug
end


function CDismantleMgr:GetClientTime()
  return self.app.Game:GetMainSystem():GetClientTime()
end

function CDismantleMgr:Dismantle()
 
  if not self.enabled then
    return
  end

  local interval = self:GetClientTime() - self.time_last
  if interval < self.interval then
    return
  end

  for i = 0, 35 do
    local itemId = self.app.Game:GetSlotItemID(i)
	if itemId ~= 0 then
	  --print(string.format("dismantling itemId %d", itemId))
	end
  end  
  
  self.app.Game:DismantleItem(0)
  --self.app.Game:DismantleItems(0,36)
    
  self.time_last = self:GetClientTime()  
end

function CDismantleMgr:OnUpdate()
  local status = "OFF"
  local color = clRed
  if self.enabled then
    status = "ON"
	color = clGreen
  end
  
  self.font:Draw(10,90-10,0,0, color, string.format("[F1] Dismantling %s", status))
end

function CDismantleMgr:WindowProc(msg)
  if msg.message == WM_KEYUP then
    if msg.wParam == VK_F1 then
	  self.enabled = not self.enabled
	end
  end
end