function c1233.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1233.spcon)
	e1:SetOperation(c1233.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1233,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c1233.cost)
	e2:SetTarget(c1233.target)
	e2:SetOperation(c1233.operation)
	c:RegisterEffect(e2)
end
function c1233.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,1169)
		and Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,1170)
		and Duel.CheckReleaseGroupEx(tp,Card.IsCode,1,nil,1228)
end
function c1233.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,1169)
	local g2=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,1170)
	local g3=Duel.SelectReleaseGroupEx(tp,Card.IsCode,1,1,nil,1228)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Release(g1,REASON_COST)
end
function c1233.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c1233.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1233.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,99999999)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingTarget(c1233.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,1169)
		and Duel.IsExistingTarget(c1233.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,1170)
		and Duel.IsExistingTarget(c1233.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,1228) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c1233.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,1169)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c1233.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,1170)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c1233.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,1228)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c1233.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,99999999) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
