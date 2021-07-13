function c1164.initial_effect(c)
	aux.AddCodeList(c,1061)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c1164.spcon)
	e2:SetOperation(c1164.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c1164.sdescon)
	e3:SetOperation(c1164.sdesop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c1164.dircon)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetCondition(c1164.atcon)
	e5:SetValue(c1164.atlimit)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e6:SetCondition(c1164.atcon)
	c:RegisterEffect(e6)
	--cannot attack
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetOperation(c1164.atklimit)
	c:RegisterEffect(e7)
	--attack cost
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_ATTACK_COST)
	e8:SetCost(c1164.atcost)
	e8:SetOperation(c1164.atop)
	c:RegisterEffect(e8)
end
function c1164.cfilter(c)
	return c:IsFaceup() and c:IsCode(1061)
end
function c1164.spcfilter(c,ft,tp)
	return ft>0 or (c:IsControler(tp) and c:GetSequence()<5)
end
function c1164.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return Duel.IsExistingMatchingCard(c1164.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and ft>-1 and Duel.CheckReleaseGroup(tp,c1164.spcfilter,1,nil,ft,tp)
end
function c1164.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectReleaseGroup(tp,c1164.spcfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c1164.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==1061 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c1164.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1164.sfilter,1,nil)
end
function c1164.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c1164.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c1164.dircon(e)
	return not Duel.IsExistingMatchingCard(c1164.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c1164.atcon(e)
	return Duel.IsExistingMatchingCard(c1164.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c1164.atlimit(e,c)
	return not c:IsType(TYPE_TOON) or c:IsFacedown()
end
function c1164.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c1164.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c1164.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
