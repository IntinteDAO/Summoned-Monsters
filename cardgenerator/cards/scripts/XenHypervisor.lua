function c1216.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1216.val)
	c:RegisterEffect(e1)
end
function c1216.val(e,c)
	return Duel.GetMatchingGroupCount(c1216.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*200
end
function c1216.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
