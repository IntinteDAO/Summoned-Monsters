function c1179.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1179,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c1179.target)
	e1:SetOperation(c1179.operation)
	c:RegisterEffect(e1)
end
c1179.toss_coin=true
function c1179.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c1179.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
		local opt=Duel.AnnounceCoin(tp)
		local coin=Duel.TossCoin(tp,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		if opt==coin then
			e1:SetValue(math.ceil(c:GetAttack()/2))
		else
			e1:SetValue(c:GetAttack()*2)
		end
		c:RegisterEffect(e1)
	end
end
