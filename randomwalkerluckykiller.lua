counter = 0
function randomwalkerluckykillerwhatTo( agent, actorKnowledge, time)
  --Zmienne
  friends = actorKnowledge:getSeenFriends()
  enemies = actorKnowledge:getSeenFoes()
  changeWeapon = 0

  -- randomowy ruch
  if ( actorKnowledge:isMoving()==false) then
    agent:moveTo(Vector4d(math.random(0,200),math.random(0,200),0,0))
  end

  -- zmiana broni
  if ( actorKnowledge:getAmmo( actorKnowledge:getWeaponType()) == 0) then
    weapon = actorKnowledge:getWeaponType()
    weapon = weapon + 1
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
          agent:shootAtPoint( enemies:at(0):getPosition())
        end
        
      else
        if (enemies:size() > 0 ) then --jeśli nie widzisz przyjaciól to strzelaj w wroga 
          agent:shootAtPoint(enemies:at(0):getPosition())
        end
      end 
    end
  end
end;

--shotgun na start
function randomwalkerluckykilleronStart( agent, actorKnowledge, time)
  agent:selectWeapon(Enumerations.Shotgun);
  showVector(dirFriends)

end

--testy wektorów
function showVector( vector)
  -- io.write( "(", vector:value(0), ",", vector:value(1), ",", vector:value(2), ",", vector:value(3),");")
  
end;