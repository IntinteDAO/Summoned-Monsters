function c1245.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1245.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c1245.val(e,c)
	return Duel.GetMatchingGroupCount(c1245.filter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*400
end
function c1245.filter(c)
	return c:IsFaceup() and c:IsCode(1238)
end
