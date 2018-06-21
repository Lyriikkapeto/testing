aseet = love.graphics.newImage("ase materiaalit/aselista.png")

function inv()
    inv={}
    function inv.setRynkky(ase)
        inv.rynkky = ase
    end
    function inv.setPistooli(ase)
        inv.pistooli = ase
    end
    function inv.setKonepistooli(ase)
        inv.konepistooli = ase
    end
    function inv.kranaatti(ase)
        inv.kranaatti = ase
    end
	return inv
end





function uusiase(dmg, kapas, nopeus, rt, rng, vel, rank, rad)
ase = {}
function ase.setQuad(qd)
ase.quad=qd
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
ase.reloadtime = rt
ase.range = rng
ase.velocity = vel
ase.radius = rad
ase.shoot = function()
    if ase.lipas>0 then
        ase.lipas=ase.lipas-1
    else
        love.timer.sleep(reloadtime)
        ase.lipas=ase.kap
    end
    end
return ase
end

--damage, kapasiteetti, nopeus, reload aika, range, vel, rank, rad
FnFal = uusiase(10, 20, 0.2, 1.5, 8, 1, 1)
FnFal.setTyyli("Rynnäkkökivääri")
FnFal.setQuad(love.graphics.newQuad(0,1,47,39))

Vz61 = uusiase(5, 20, 0.6, 1, 5, 1, 0, 1 )
Vz61.setTyyli("Konepistooli")

Vz58 = uusiase(7, 30, 0.2, 1.5, 8, 1, 0, 1 )
Vz58.setTyyli("Rynnäkkökivääri")
Vz58.setQuad(104,1,49,32)

TT33 = uusiase(5, 8, 0.6, 0.8, 6, 1, 0, 1)
TT33.setTyyli("Pistooli")
TT33.setQuad(love.graphics.newQuad(191,0,31,33))
Makarov = uusiase(6.5, 8, 0.6, 0.8, 5, 1, 1, 1)
Makarov.setTyyli("Pistooli")
Makarov.setQuad(love.graphics.newQuad(157,1,31,34))

PPsh41 = uusiase(5, 71, 1, 0.2, 6, 1, 1, 1)
PPsh41.setTyyli("Konepistooli")
PPsh41.setQuad(love.graphics.newQuad(49,0,51,40))

OletusInv = inv()
OletusInv.setPistooli(TT33)