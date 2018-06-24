aseet = love.graphics.newImage("ase materiaalit/aselista.png")
function inv()
   local inv={}
    function inv.setAse(ase)
        inv[ase.tyyli] = ase
    end
	function inv.delete(index)
		inv[index]=nil
	end
	function inv.getGun(gun)
		return inv[gun.tyyli]
	end
	function inv.getBest()--Valitsee aseen
		if inv["Rynnäkkökivääri"]~=nil then
			return inv["Rynnäkkökivääri"]
		end
		if inv["Konepistooli"]~=nil then
			return inv["Konepistooli"]
		end
		if inv["Pistooli"]~=nil then
			return inv["Pistooli"]
		end
			return puukko
	end
	return inv
end





function uusiase(kapas)
local ase = {}
function ase.setQuad(qd)
ase.quad=qd
end
function ase.getQuad()
return ase.quad
end
function ase.setTyyli(tyyli)
    ase.tyyli=tyyli
end

ase.kap = kapas --kapasiteetti
ase.lipas = kapas
ase.storage=5--lippaiden määrä
ase.getStorage=function() return ase.storage end
ase.load=function() ase.lipas=0 end
ase.setStorage=function(num) ase.storage=num end
ase.counter=0
ase.radius = rad
ase.printMag=function()
	love.graphics.print(ase.lipas.."/"..ase.kap.."	 lippaat:"..ase.storage, 28*ts, 5*ts, 0, 2, 2)
end
ase.shoot = function()
    if ase.lipas>0 then
        ase.lipas=ase.lipas-1
		table.insert(bullets, {px, py, suunta})
    else
	throwsign=true
	text="Keep pressing space to reload: "..math.floor((ase.kap/2-ase.counter/2)-2)
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
		throwsign=false
		OletusInv.delete(ase.tyyli)
	end
    end
    end
return ase
end

--damage, kapasiteetti, nopeus, reload aika, range, vel, rank, rad
FnFal = uusiase(20)
FnFal.setTyyli("Rynnäkkökivääri")
FnFal.setQuad(love.graphics.newQuad(0,1,47,39, aseet:getDimensions()))
FnFal.setStorage(5)
Vz61 = uusiase(20)
Vz61.setTyyli("Konepistooli")

Vz58 = uusiase(30)
Vz58.setTyyli("Rynnäkkökivääri")
Vz58.setQuad(love.graphics.newQuad(104,1,49,32, aseet:getDimensions()))

TT33 = uusiase(8)
TT33.setTyyli("Pistooli")
TT33.setQuad(love.graphics.newQuad(191,0,31,33, aseet:getDimensions()))
TT33.setStorage(math.huge)--pistää arvoksi loputtomuuden
Makarov = uusiase(8)
Makarov.setTyyli("Pistooli")
Makarov.setQuad(love.graphics.newQuad(157,1,31,34, aseet:getDimensions()))

PPsh41 = uusiase(71)
PPsh41.setTyyli("Konepistooli")
PPsh41.setQuad(love.graphics.newQuad(49,0,51,40, aseet:getDimensions()))
PPsh41.setStorage(1)
puukko = uusiase(0)
puukko.setTyyli("nil")
puukko.setQuad(love.graphics.newQuad(200,0,3,3, aseet:getDimensions()))
puukko.setStorage(0)
OletusInv = inv()
OletusInv.setAse(TT33)