counter = 0
function LuckyKillerJohnwhatTo( agent, actorKnowledge, time)
  --Zmienne
  friends = actorKnowledge:getSeenFriends()
  enemies = actorKnowledge:getSeenFoes()
  changeWeapon = 0

	if (actorKnowledge:isMoving() == false) then
		nav = actorKnowledge:getNavigation()
		foundTarget = false
		
		for i = 0, nav:getNumberOfTriggers() - 1, 1 do
		trig = nav:getTrigger(i)
		dist = trig:getPosition() - actorKnowledge:getPosition()


		--no heath
		if (trig:getType() == Trigger.Health and trig:isActive() and actorKnowledge:getHealth() < actorKnowledge:getHealth() * 0.7) then
			agent:moveTo(trig:getPosition())
			foundTarget = true
		elseif (trig:getType() == Trigger.Armour and trig:isActive() and actorKnowledge:getHealth() < actorKnowledge:getHealth() * 0.7) then
			agent:moveTo(trig:getPosition())
			foundTarget = true
		end
		
		if (foundTarget) then
			break
		end
		end
		--random walking
		if (not foundTarget) then
		agent:moveTo(Vector4d(math.random(0, 300), math.random(0, 300), 0, 0))
		end
	end

  	-- no ammo
	if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) == 0 or actorKnowledge:getAmmo(Enumerations.Railgun) == 0 or actorKnowledge:getAmmo(Enumerations.Shotgun) == 0 or actorKnowledge:getAmmo(Enumerations.Chaingun) == 0) then
		nav = actorKnowledge:getNavigation()
		for i = 0, nav:getNumberOfTriggers() - 1, 1 do
			trig = nav:getTrigger(i)
			if (trig:getType() == Trigger.Weapon and trig:isActive()) then
				agent:moveTo(trig:getPosition())
			end
		end
	end

  -- zmiana broni
  if ( actorKnowledge:getAmmo( actorKnowledge:getWeaponType()) == 0) then
    weapon = actorKnowledge:getWeaponType()
    weapon = (weapon + 1) % 4
      agent:selectWeapon( weapon)
    changeWeapon = 1
  end

  -- strzelanie do wroga i nie strzelanie do kolegów
  if ( enemies:size() > 0) then --jeśli widzi wroga
    if ( changeWeapon == 0) then
      if (enemies:size()>0 and friends:size()>0) then --sprawdź czy widzisz przyjaciół i nie strzelaj w nich, ale w wroga
        dirFriends = friends:at(0):getPosition() - actorKnowledge:getPosition()
        dirEnemy = enemies:at(0):getPosition() - actorKnowledge:getPosition()
        normalDirFriends = dirFriends:normal()
        normalDirEnemy = dirEnemy:normal()
        dotProduct = normalDirFriends:dot(normalDirEnemy)
  
        angle = math.deg(math.acos(dotProduct))
  
        if (angle > 10) then
          agent:shootAtPoint(enemies:at(0):getPosition())
        end
        
      else
        if (enemies:size() > 0 ) then --jeśli nie widzisz przyjaciól to strzelaj w wroga 
          agent:shootAtPoint(enemies:at(0):getPosition())
        end
      end 
    end
  end
end;

--Shotgun na start
function LuckyKillerJohnonStart( agent, actorKnowledge, time)
  agent:selectWeapon(Enumerations.Chaingun);
end

--testy wektorów
function showVector( vector)
  -- io.write( "(", vector:value(0), ",", vector:value(1), ",", vector:value(2), ",", vector:value(3),");")
end;

