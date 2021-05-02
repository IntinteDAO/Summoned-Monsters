function c1101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c1101.actcon)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c1101.abdcon)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c1101.sdcon)
	c:RegisterEffect(e3)
end
function c1101.check()
	return Duel.IsEnvironment(1009)
end
function c1101.actcon(e,tp,eg,ep,ev,re,r,rp)
	return c1101.check()
end
function c1101.abdcon(e)
	local at=Duel.GetAttackTarget()
	return c1101.check() and (at==nil or at:IsAttackPos() or Duel.GetAttacker():GetAttack()>at:GetDefense())
end
function c1101.sdcon(e)
	return not c1101.check()
end
