function c1106.initial_effect(c)
	--destroy equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1106,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_EQUIP)
	e1:SetTarget(c1106.destg)
	e1:SetOperation(c1106.desop)
	c:RegisterEffect(e1)
end
function c1106.filter(c,ec)
	return c:GetEquipTarget()==ec
end
function c1106.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=eg:Filter(c1106.filter,nil,e:GetHandler())
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c1106.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(tg,REASON_EFFECT)
end
