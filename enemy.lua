function enemy(x, y, speed) -- x ja y on vihollisen paikka ja speed sen nopeus, nopeus 0.1 on perus ja 0.2 yhtä nopea kuin pelaaja

local enem = {}
if speed==nil then speed=0.1 end--jos speediä ei ole merkitty se on 0.1
enem.x=x
enem.y=y
enem.timer=true
enem.tyyli="Harmless"
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
return enem
end
function dangerenemy(x, y, speed)
	local enem = enemy(x,y,speed)
	enem.tyyli="Harmful"
	enem.walk=function()--kävelee randomisti
	if enem.x==px and enem.y==py then
	mapChange(px,py,defmap)
	end
	if getNext(enem.x,enem.y,enem.dir) then
			if enem.dir==oikea then
				enem.xcount=enem.xcount+enem.speed
			if enem.xcount>=enem.opx+1 then
				enem.xcount=enem.opx+1
				enem.x=enem.opx+1
				enem.opx=enem.x
				if py<enem.y then
					enem.dir=ylos
				elseif py>enem.y then
					enem.dir=alas
				elseif px>enem.x then
					enem.dir=oikea
				elseif px<enem.x then
					enem.dir=vasen
				else
					mapChange(px,py, defmap)
				end
			end
			elseif enem.dir==vasen then
			enem.xcount=enem.xcount-enem.speed
			if enem.xcount<=enem.opx-1 then
				enem.xcount=enem.opx-1
				enem.x=enem.opx-1
				enem.opx=enem.x
				if py<enem.y then
					enem.dir=ylos
				elseif py>enem.y then
					enem.dir=alas
				elseif px>enem.x then
					enem.dir=oikea
				elseif px<enem.x then
					enem.dir=vasen
				else
					mapChange(px,py, defmap)
				end
			end
			elseif enem.dir==ylos then
			enem.ycount=enem.ycount-enem.speed
			if enem.ycount<=enem.opy-1 then
				enem.ycount=enem.opy-1
				enem.y=enem.opy-1
				enem.opy=enem.y				
				if px<enem.x then
					enem.dir=vasen
				elseif px>enem.x then
					enem.dir=oikea
				elseif py>enem.y then
					enem.dir=alas
				elseif py<enem.y then
					enem.dir=ylos
				else
					mapChange(px,py, defmap)
				end

			end
			elseif enem.dir==alas then
			enem.ycount=enem.ycount+enem.speed
			if enem.ycount>=enem.opy+1 then
				enem.ycount=enem.opy+1
				enem.y=enem.opy+1
				enem.opy=enem.y
				if px<enem.x then
					enem.dir=vasen
				elseif px>enem.x then
					enem.dir=oikea
				elseif py>enem.y then
					enem.dir=alas
				elseif py<enem.y then
					enem.dir=ylos
				else
					mapChange(px,py, defmap)
				end
			end
			end
			else
			enem.dir=love.math.random(1,4)
			end
		end
	return enem
end

function monster(x, y, speed) --taulukko ei ole local joten tulee ennaltaarvattamattomia seurauksia

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
return enem
end