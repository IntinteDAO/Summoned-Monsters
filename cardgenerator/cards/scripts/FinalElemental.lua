function c1229.initial_effect(c)
	--win
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetRange(LOCATION_HAND)
	e1:SetOperation(c1229.operation)
	c:RegisterEffect(e1)
end
function c1229.check(g)
	local a1=false
	local a2=false
	local a3=false
	local a4=false
	local a5=false
	local a6=false
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==1168 then a1=true
		elseif code==1209 then a2=true
		elseif code==1169 then a3=true
		elseif code==1170 then a4=true
		elseif code==1228 then a5=true
		elseif code==1229 then a6=true
		end
		tc=g:GetNext()
	end
	return a1 and a2 and a3 and a4 and a5 and a6
end
function c1229.operation(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_EXODIA = 0x10
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local wtp=c1229.check(g1)
	local wntp=c1229.check(g2)
	if wtp and not wntp then
		Duel.ConfirmCards(1-tp,g1)
		Duel.Win(tp,WIN_REASON_EXODIA)
	elseif not wtp and wntp then
		Duel.ConfirmCards(tp,g2)
		Duel.Win(1-tp,WIN_REASON_EXODIA)
	elseif wtp and wntp then
		Duel.ConfirmCards(1-tp,g1)
		Duel.ConfirmCards(tp,g2)
		Duel.Win(PLAYER_NONE,WIN_REASON_EXODIA)
	end
end
