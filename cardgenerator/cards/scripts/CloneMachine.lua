function c1192.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c1192.cost)
	e1:SetTarget(c1192.target)
	e1:SetOperation(c1192.activate)
	c:RegisterEffect(e1)
end
function c1192.cfilter(c)
	return c:IsFaceup() and c:IsCode(1023)
end
function c1192.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c1192.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c1192.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c1192.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,1999,0,0x4011,0,0,1,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,99999999) then ft=1 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c1192.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,1999,0,0x4011,0,0,1,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	if Duel.IsPlayerAffectedByEffect(tp,99999999) then ft=1 end
	for i=1,ft do
		local token=Duel.CreateToken(tp,1999)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
