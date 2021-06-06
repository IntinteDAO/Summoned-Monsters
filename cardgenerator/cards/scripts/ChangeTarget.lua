function c1129.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1129,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c1129.condition1)
	e1:SetTarget(c1129.target1)
	e1:SetOperation(c1129.activate1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1129,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c1129.condition2)
	e2:SetTarget(c1129.target2)
	e2:SetOperation(c1129.activate2)
	c:RegisterEffect(e2)
end
function c1129.condition1(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c1129.filter1(c,e)
	return c:IsCanBeEffectTarget(e)
end
function c1129.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local ag=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if chk==0 then return ag:IsExists(c1129.filter1,1,at,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=ag:FilterSelect(tp,c1129.filter1,1,1,at,e)
	Duel.SetTargetCard(g)
end
function c1129.activate1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
function c1129.condition2(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)
end
function c1129.filter2(c,ct)
	return Duel.CheckChainTarget(ct,c)
end
function c1129.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c1129.filter2(chkc,ev) end
	if chk==0 then return Duel.IsExistingTarget(c1129.filter2,tp,LOCATION_MZONE,0,1,e:GetLabelObject(),ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c1129.filter2,tp,LOCATION_MZONE,0,1,1,e:GetLabelObject(),ev)
end
function c1129.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
end
