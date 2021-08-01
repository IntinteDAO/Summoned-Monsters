function c1182.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1182,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c1182.target)
	e1:SetOperation(c1182.operation)
	c:RegisterEffect(e1)
end
function c1182.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,3)
end
function c1182.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==0 then return end
	Duel.BreakEffect()
	local g=Duel.GetOperatedGroup()
	Duel.ConfirmCards(1-p,g)
	local dg=g:Filter(Card.IsType,nil,TYPE_SPELL)
	Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(p)
end
