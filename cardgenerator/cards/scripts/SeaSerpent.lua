function c1070.initial_effect(c)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c1070.econ)
	e1:SetValue(c1070.efilter)
	c:RegisterEffect(e1)
end
function c1070.econ(e)
	return Duel.IsEnvironment(1009)
end
function c1070.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
