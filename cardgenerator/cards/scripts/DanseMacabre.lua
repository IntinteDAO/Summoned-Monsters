function c1226.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c1226.cost)
	e1:SetOperation(c1226.activate)
	c:RegisterEffect(e1)
end
function c1226.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c1226.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetFlagEffect(tp,1226)~=0 then return end
	Duel.RegisterFlagEffect(tp,1226,RESET_PHASE+PHASE_END,0,20)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetOperation(c1226.checkop)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END,20)
	Duel.RegisterEffect(e1,tp)
	c:RegisterFlagEffect(9999999,RESET_PHASE+PHASE_END,0,20)
	c1226[c]=e1
end
function c1226.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetFlagEffect(tp,1226)
	c:SetHint(CHINT_TURN,ct)
	Duel.RegisterFlagEffect(tp,1226,RESET_PHASE+PHASE_END,0,21-ct)
	if ct==20 then
		Duel.Win(tp,0x11)
		c:ResetFlagEffect(9999999)
	end
end
