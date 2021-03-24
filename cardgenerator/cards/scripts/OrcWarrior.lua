function c1072.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c1072.value)
	c:RegisterEffect(e1)
end
function c1072.filter(c)
	return c:IsFaceup() and c:IsCode(1071)
end
function c1072.value(e,c)
	return Duel.GetMatchingGroupCount(c1072.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
