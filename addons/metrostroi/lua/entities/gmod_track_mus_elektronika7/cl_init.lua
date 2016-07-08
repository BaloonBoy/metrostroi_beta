include("shared.lua")
ENT.DigitPositions = {
  Vector(0,17,0),
  Vector(0,7,0),
  Vector(0,-6.5,0),
  Vector(0,-16.5,0),
}

function ENT:Initialize()
    self.Digits = {}
end

function ENT:Think()
	for k,v in pairs(self.DigitPositions) do
		if not IsValid(self.Digits[k]) then
			self.Digits[k] = ClientsideModel("models/mus/ussr_clock_model/num_"..(k == 1 and "no" or "").."zero.mdl",RENDERGROUP_OPAQUE)
			self.Digits[k]:SetPos(self:LocalToWorld(v))
			self.Digits[k]:SetAngles(self:GetAngles())
			self.Digits[k]:SetSkin(10)
			self.Digits[k]:SetParent(self)
		end
	end

	local d = os.date("!*t",Metrostroi.GetSyncTime())
	if IsValid(self.Digits[1]) then self.Digits[1]:SetSkin(math.floor(d.hour / 10)) end
	if IsValid(self.Digits[2]) then self.Digits[2]:SetSkin(math.floor(d.hour % 10)) end
	if IsValid(self.Digits[3]) then self.Digits[3]:SetSkin(math.floor(d.min  / 10)) end
	if IsValid(self.Digits[4]) then self.Digits[4]:SetSkin(math.floor(d.min  % 10)) end
end

function ENT:OnRemove()
  for _,v in pairs(self.Digits) do
		SafeRemoveEntity(v)
	end
end
function ENT:Draw()
	self:DrawModel()
end
