function enemy(health, x, y, speed) 

local enem = {}

enem.x=x
enem.y=y
enem.timer=true
enem.xcount=x
enem.ycount=y
enem.speed=speed
enem.getPos = function() return {enem.xcount*ts,enem.ycount*ts} end
enem.opx=x --original player x
enem.opy=y --original player y
enem.dir=love.math.random(1,4) --suunta
enem.walk=function()--kävelee randomisti

	if getNext(enem.x,enem.y,enem.dir) then
			if enem.dir==oikea then
				enem.xcount=enem.xcount+enem.speed
			if enem.xcount>=enem.opx+1 then
				enem.xcount=enem.opx+1
				enem.x=enem.opx+1
				enem.opx=enem.x
				enem.dir = love.math.random(1,4)
			end
			elseif enem.dir==vasen then
			enem.xcount=enem.xcount-enem.speed
			if enem.xcount<=enem.opx-1 then
				enem.xcount=enem.opx-1
				enem.x=enem.opx-1
				enem.opx=enem.x
				enem.dir = love.math.random(1,4)
			end
			elseif enem.dir==ylos then
			enem.ycount=enem.ycount-enem.speed
			if enem.ycount<=enem.opy-1 then
				enem.ycount=enem.opy-1
				enem.y=enem.opy-1
				enem.opy=enem.y				
				enem.dir = love.math.random(1,4)

			end
			elseif enem.dir==alas then
			enem.ycount=enem.ycount+enem.speed
			if enem.ycount>=enem.opy+1 then
				enem.ycount=enem.opy+1
				enem.y=enem.opy+1
				enem.opy=enem.y
				enem.dir = love.math.random(1,4)
			end
			end
			else
			enem.dir=love.math.random(1,4)
			end
		end

enem.health=health
return enem
end

function monster(health, x, y, speed) --taulukko ei ole local joten tulee ennaltaarvattamattomia seurauksia

enem = {}

enem.x=x
enem.y=y
enem.timer=true
enem.xcount=x
enem.ycount=y
enem.speed=speed
enem.getPos = function() return {enem.xcount*ts,enem.ycount*ts} end
enem.opx=x --original player x
enem.opy=y --original player y
enem.dir=love.math.random(1,4) --suunta
enem.walk=function()--kävelee randomisti

	if getNext(enem.x,enem.y,enem.dir) then
			if enem.dir==oikea then
				enem.xcount=enem.xcount+enem.speed
			if enem.xcount>=enem.opx+1 then
				enem.xcount=enem.opx+1
				enem.x=enem.opx+1
				enem.opx=enem.x
				enem.dir = love.math.random(1,4)
			end
			elseif enem.dir==vasen then
			enem.xcount=enem.xcount-enem.speed
			if enem.xcount<=enem.opx-1 then
				enem.xcount=enem.opx-1
				enem.x=enem.opx-1
				enem.opx=enem.x
				enem.dir = love.math.random(1,4)
			end
			elseif enem.dir==ylos then
			enem.ycount=enem.ycount-enem.speed
			if enem.ycount<=enem.opy-1 then
				enem.ycount=enem.opy-1
				enem.y=enem.opy-1
				enem.opy=enem.y				
				enem.dir = love.math.random(1,4)

			end
			elseif enem.dir==alas then
			enem.ycount=enem.ycount+enem.speed
			if enem.ycount>=enem.opy+1 then
				enem.ycount=enem.opy+1
				enem.y=enem.opy+1
				enem.opy=enem.y
				enem.dir = love.math.random(1,4)
			end
			end
			else
			enem.dir=love.math.random(1,4)
			end
		end

enem.health=health
return enem
end