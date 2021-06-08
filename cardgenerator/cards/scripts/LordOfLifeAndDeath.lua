function c1131.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1131,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_RECOVER)
	e1:SetCondition(c1131.cd)
	e1:SetOperation(c1131.op)
	c:RegisterEffect(e1)
end
function c1131.cd(e,tp,eg,ep,ev,re,r,rp)
	return tp==ep
end
function c1131.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
