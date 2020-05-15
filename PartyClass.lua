--[=[ PartyClass
	by Caandera
	released under the Creative Commons License By-Nc-Sa: http://creativecommons.org/licenses/by-nc-sa/3.0/
]=]

function PartyClassButton_Load(this)
	this:RegisterEvent("PARTY_MEMBER_CHANGED");
	this:RegisterEvent("UNIT_CLASS_CHANGED");
	this:RegisterEvent("PARTY_INVITE_REQUEST"); 
	this:RegisterEvent("PARTY_LEADER_CHANGED");
end;

function PartyClassButton_Update(this)
	local id = this:GetID();
	local class1, class2 = UnitClassToken("party"..id);
	local targetFrame = getglobal("UnitFrame_party"..id);
	if class1 ~= nil and class2 ~= nil and targetFrame:IsVisible() then
		local picString = "interface/widgeticons/classicon_"..string.lower(class1);
		if class2 ~= "" then
			picString = picString.."_"..string.lower(class2);
		end;
		local frame = getglobal(this:GetName().."Icon");
		frame:SetTexture(picString..".tga");
	end
end;

function PartyClassButton_Event(event, this)
	if ( event == "PARTY_MEMBER_CHANGED" or event == "UNIT_CLASS_CHANGED" or
	event == "PARTY_INVITE_REQUEST" or event == "PARTY_LEADER_CHANGED") then
		PartyClassButton_Update(this);
	end;
end;

function PartyClassButton_Enter(this)
	PartyClassTooltip:ClearAllAnchors();
	PartyClassTooltip:SetAnchor("TOPLEFT", "BOTTOMRIGHT", this:GetName(), 0, 0);
	local id = this:GetID();
	PartyClassTooltip:SetText(UnitName("party"..id));
	local mainClass, subClass = UnitClass("party"..id);
	local mlvl, slvl = UnitLevel("party"..id);
	PartyClassTooltip:AddDoubleLine(mainClass, mlvl);
	if subClass ~= "" then
		PartyClassTooltip:AddDoubleLine(subClass, slvl);
	end;
end;

function PartyClassRaidButton_Load(this)
	this:RegisterEvent("PARTY_MEMBER_CHANGED");
	this:RegisterEvent("UNIT_CLASS_CHANGED");
	this:RegisterEvent("RAID_TARGET_CHANGED"); 
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	
	--this:SetAlpha(0.3);
end;

function PartyClassRaidButton_Update(this)
	local id = this:GetID();
	local class1, class2 = UnitClassToken("raid"..id);
	local unitFrm = id%6;
	if unitFrm == 0 then unitFrm = 6 end;
	local raidFrm = math.ceil(id/6);
	--Für Tests:
	--DEFAULT_CHAT_FRAME:AddMessage("RaidPartyFrame"..raidFrm.."UnitFrame"..unitFrm.." ID="..id, 0.5, 0.7, 0.1);
	local targetFrame = getglobal("RaidPartyFrame"..raidFrm.."UnitFrame"..unitFrm);
	if class1 ~= nil and class2 ~= nil and targetFrame:IsVisible() then
		local picString = "interface/widgeticons/classicon_"..string.lower(class1);
		if class2 ~= "" then
			picString = picString.."_"..string.lower(class2);
		end;
		local frame = getglobal(this:GetName().."Icon");
		frame:SetTexture(picString..".tga");
		this:Show();
	else
		this:Hide();
	end
end;

function PartyClassRaidButton_Event(event, this)
	if ( event == "PARTY_MEMBER_CHANGED" or event == "UNIT_CLASS_CHANGED" or
	event == "RAID_TARGET_CHANGED" or event == "PARTY_LEADER_CHANGED") then
		PartyClassRaidButton_Update(this);
	end;
end;

function PartyClassRaidButton_Enter(this)
	PartyClassTooltip:ClearAllAnchors();
	PartyClassTooltip:SetAnchor("TOPLEFT", "BOTTOMRIGHT", this:GetName(), 0, 0);
	local id = this:GetID();
	PartyClassTooltip:SetText(UnitName("raid"..id));
	local mainClass, subClass = UnitClass("raid"..id);
	local mlvl, slvl = UnitLevel("raid"..id);
	PartyClassTooltip:AddDoubleLine(mainClass, mlvl);
	if subClass ~= "" then
		PartyClassTooltip:AddDoubleLine(subClass, slvl);
	end;
	PartyClassTooltip:AddLine("");
	PartyClassTooltip:AddLine("LP: "..UnitHealth("raid"..id).."/"..UnitMaxHealth("raid"..id));
end;


DEFAULT_CHAT_FRAME:AddMessage("Addon loaded. PartyClass v1.2", 0.5, 0.7, 0.1);