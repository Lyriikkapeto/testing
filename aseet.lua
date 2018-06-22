aseet = love.graphics.newImage("ase materiaalit/aselista.png")

function inv()
   local inv={}
    function inv.setRynkky(ase)
        inv.rynkky = ase
    end
	function inv.getRynkky()
		return inv.rynkky
	end
    function inv.setPistooli(ase)
        inv.pistooli = ase
    end
	function inv.getPistooli()
		return inv.pistooli
	end
    function inv.setKonepistooli(ase)
        inv.konepistooli = ase
    end
    function inv.setKranaatti(ase)
        inv.kranaatti = ase
    end
	function inv.getBest()--listaa käytettävissä olevat aseet
		if inv.rynkky~=nil then
			return inv.rynkky
		end
		if inv.pistooli~=nil then
			return inv.pistooli
		end
	end
	return inv
end





function uusiase(dmg, kapas, nopeus, rt, rng, vel, rank, rad)
local ase = {}
function ase.setQuad(qd)
ase.quad=qd
end
function ase.getQuad()
return ase.quad
end
-----Metataulukko aseiden vertailuun
local mt = {}
mt.rank=rank
mt.__lt = function(a,b)
    return a.rank<b
end
setmetatable(ase, mt)
---------------------
function ase.setTyyli(tyyli)
    ase.tyyli=tyyli
end
function ase.vertaa(ase)
return mt.rank>getmetatable(ase).rank
end
ase.damage = dmg
ase.kap = kapas --kapasiteetti
ase.lipas = kapas
ase.rps = nopeus
ase.storage=5--lippaiden määrä
ase.reloadtime = rt
ase.range = rng
ase.velocity = vel
ase.counter=0
ase.radius = rad
ase.printMag=function()
	love.graphics.print(ase.lipas.."/"..ase.kap, 28*ts, 5*ts, 0, 2, 2)
end
ase.shoot = function()
    if ase.lipas>0 then
        ase.lipas=ase.lipas-1
    else
	throwsign=true
	text="Keep pressing space to reload: "..(ase.counter/2).."/"..(ase.kap/4)
	if ase.storage>0 then
		ase.counter = ase.counter+2
		if ase.counter>=ase.kap then
			ase.counter=0
			ase.lipas=ase.kap
			throwsign=false
			text=nil
			ase.storage=ase.storage-1
		end
	else
		print("out of ammo")
		ase = nil
	end
    end
    end
return ase
end

--damage, kapasiteetti, nopeus, reload aika, range, vel, rank, rad
FnFal = uusiase(10, 20, 0.2, 1.5, 8, 1, 1)
FnFal.setTyyli("Rynnäkkökivääri")
FnFal.setQuad(love.graphics.newQuad(0,1,47,39, aseet:getDimensions()))

Vz61 = uusiase(5, 20, 0.6, 1, 5, 1, 0, 1 )
Vz61.setTyyli("Konepistooli")

Vz58 = uusiase(7, 30, 0.2, 1.5, 8, 1, 0, 1 )
Vz58.setTyyli("Rynnäkkökivääri")
Vz58.setQuad(love.graphics.newQuad(104,1,49,32, aseet:getDimensions()))

TT33 = uusiase(5, 8, 0.6, 0.8, 6, 1, 0, 1)
TT33.setTyyli("Pistooli")
TT33.setQuad(love.graphics.newQuad(191,0,31,33, aseet:getDimensions()))
Makarov = uusiase(6.5, 8, 0.6, 0.8, 5, 1, 1, 1)
Makarov.setTyyli("Pistooli")
Makarov.setQuad(love.graphics.newQuad(157,1,31,34, aseet:getDimensions()))

PPsh41 = uusiase(5, 71, 1, 0.2, 6, 1, 1, 1)
PPsh41.setTyyli("Konepistooli")
PPsh41.setQuad(love.graphics.newQuad(49,0,51,40, aseet:getDimensions()))

OletusInv = inv()
OletusInv.setPistooli(TT33)