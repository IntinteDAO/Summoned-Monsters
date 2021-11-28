function c1163.initial_effect(c)
	aux.AddCodeList(c,1061)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c1163.atklimit)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c1163.sdescon)
	e4:SetOperation(c1163.sdesop)
	c:RegisterEffect(e4)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	e5:SetCondition(c1163.dircon)
	c:RegisterEffect(e5)
	--attack cost
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_ATTACK_COST)
	e6:SetCost(c1163.atcost)
	e6:SetOperation(c1163.atop)
	c:RegisterEffect(e6)
	end
function c1163.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c1163.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==1061 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c1163.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1163.sfilter,1,nil)
end
function c1163.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c1163.dirfilter1(c)
	return c:IsFaceup() and c:IsCode(1061)
end
function c1163.dirfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c1163.dircon(e)
	return Duel.IsExistingMatchingCard(c1163.dirfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c1163.dirfilter2,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c1163.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c1163.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c1163.atcost(e,c,tp)
    return Duel.CheckLPCost(tp,0)
end
function c1163.atop(e,tp,eg,ep,ev,re,r,rp)
    Duel.PayLPCost(tp,0)
end