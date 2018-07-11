require("aseet")
require("enemy")
require("maps")
function love.load()
--define
sec = function() return (_G.dt*59) end
--
	score=0
	inventory = OletusInv
	map = defmap --katso maps.lua
	tileset = love.graphics.newImage("tileset.png")
	luoti=love.graphics.newImage("Patruuna.png")
	ts=32 --tilen koko
	quads = {} --taulukko quadeista eli tileistä
	quads[0] = love.graphics.newQuad(ts*0, 0, ts, ts, tileset:getDimensions())--tyhjyys
	quads[1] = love.graphics.newQuad(ts*8, 0, ts, ts, tileset:getDimensions())--tiiliseinä
	quads[2] = love.graphics.newQuad(ts*1, 0, ts, ts, tileset:getDimensions())--maa
	quads[3] = love.graphics.newQuad(ts*9, 0, ts, ts, tileset:getDimensions())--tiili
	quads[4] = love.graphics.newQuad(ts*10, 0, ts, ts, tileset:getDimensions())--tiili
	quads[5] = love.graphics.newQuad(ts*0, ts*21, ts, ts, tileset:getDimensions())--tiheäruoho
	quads[6] = love.graphics.newQuad(ts*0, ts*20, ts, ts, tileset:getDimensions())--nurmikko
	quads[7] = love.graphics.newQuad(448, 443, ts, ts, tileset:getDimensions())--tyyppi
	quads[8] = love.graphics.newQuad(ts*4, ts*20, ts, ts, tileset:getDimensions())--oksa
	quads[9] = love.graphics.newQuad(320, 416, ts, ts, tileset:getDimensions())--harmaa
	quads[10]=love.graphics.newQuad(96, 230, ts, ts, tileset:getDimensions()) --ovi
	quads[11]=quads[10]
	heads = {}--lataa tikkuukon päät
	for i=1, 4 do
		heads[i] = love.graphics.newQuad(ts*(10+i), 0, ts, ts, tileset:getDimensions())
	end
	allowed = {[2] = true, [1]=false, [3]=false, [4]=false, [5]=true, [6]=true, [7]=false, [8]=false, [0]=true, [10]=false, [11]=true}
	px, py = 3, 3 --pelaajan x ja y tileissä
	opx, opy = 3, 3 --muuttujat jotka tallentaa pelaajan position liikkumisen ajaksi
--älä välitä 
	ylos=4
	vasen=2
	alas=1
	oikea=3
--suuntien numero koodit
cooldown=0--assaultriflen cooldown
suunta=alas
timer=true--onko ajastus mennyt yli
counter=0 --laskee pikseletä kävelyssä
bullets={}
enemies={}
guns={}
end
function tilePos(x,y)--oalauttaa oikean position mappiposition pohjalta
return ts*x, ts*y
end
function getNextTile(x,y, suunta) --tarkastaa onko seuraava tilee suunnassa vapaa
if map ~= nil then
	if suunta==oikea then
	x=math.ceil(x)
		return map[y][x+1], y, x+1
	end
	if suunta==vasen then
	x=math.floor(x)
		return map[y][x-1], y, x-1
	end
	if suunta==ylos then
	y=math.floor(y)
		return map[y-1][x], y-1, x
	end
	if suunta==alas then
	y=math.ceil(y)
		return map[y+1][x], y+1, x
	end
end
return false
end
function getNext(x,y, suunta) --tarkastaa onko seuraava tilee suunnassa vapaa
if map then
	if suunta==oikea then
		if allowed[map[y][x+1]] then return true end
	end
	if suunta==vasen then
		if allowed[map[y][x-1]] then return true end
	end
	if suunta==ylos then
		if allowed[map[y-1][x]] then return true end
	end
	if suunta==alas then
		if allowed[map[y+1][x]] then return true end
	end
end
return false
end
function mapChange(x,y,newmap, startpos)
if newmap==defmap then score=0 end
	if px==x and py==y then
		map=newmap
		for y,x in pairs(map) do
			for i,v in pairs(map[y]) do
				if v==11 then map[y][i]=10 end
			end
		end
		if not startpos then
		opx, px=getmetatable(newmap).startpos[1], getmetatable(newmap).startpos[1]
		opy, py=getmetatable(newmap).startpos[2], getmetatable(newmap).startpos[2]
		else
		for i,v in pairs(startpos) do
		print(i,v)
		end
		opx,px = startpos[1], startpos[1]
		opy,py=startpos[2], startpos[2]
		print(px,py)
		end
		bullets={}
		enemies={}
		guns={}
		if getmetatable(newmap).guns ~= nil then
			table.insert(guns, getmetatable(newmap).guns)
		end
		for i,v in pairs(getmetatable(newmap).enemies) do
			table.insert(enemies, v[1](v[2],v[3],v[4]))
		end
	end
end
function love.draw()
love.graphics.print("Score: "..score, 28*ts,17*ts)
	
	for y,xtaulukko in pairs(map) do --Piirtää mapin
		for x,quadnumero in pairs(xtaulukko) do
			love.graphics.draw(tileset, quads[quadnumero], x*ts, y*ts)
		end
	end
	
	love.graphics.draw(tileset, heads[suunta], px*ts, py*ts) --piirtää pelaajan
	if inventory.getBest()~=nil then --tämä tarkastaa onko asetta olemassa
	inventory.getBest().printMag()
	if suunta==oikea then --piirtää aseet riippuen suunnasta
	love.graphics.draw(aseet, inventory.getBest().getQuad(), px*ts+16, py*ts+18, 0, 0.5, 0.5)
	elseif suunta==vasen or suunta==alas then
	love.graphics.draw(aseet, inventory.getBest().getQuad(), px*ts+16, py*ts+18, 0, -0.5, 0.5) --riippuen suunnata vaihtaa aseen skaalaa
	end
	end

	for i,v in pairs(bullets) do
		love.graphics.draw(luoti, v[1]*ts, v[2]*ts) --v[1]=x v[2]=y v[3]=suunta

		v[1]=math.floor(v[1])
		v[2]=math.floor(v[2])
			if getNext(v[1], v[2], v[3]) then
			print(sec())
				if v[3]==oikea then v[1]=v[1]+sec() --lisää dt
				elseif v[3]==vasen then v[1]=v[1]-sec() --sec on nopeus suhteutenn
				elseif v[3]==ylos then v[2]=v[2]-sec()
				elseif v[3]==alas then v[2]=v[2]+sec() end
			else
				table.remove(bullets, i)
			end
		for a,b in pairs(enemies) do
			if b.x==math.floor(v[1]+0.5) and b.y==math.floor(v[2]+0.5) then --math.floor(x+0.5) on normaali pyörentäminen
				if b.tyyli=="Harmless" then
				score=score+100
				elseif b.tyyli=="Harmful" then
				score=score+150
				end
				table.remove(enemies, a)
				table.remove(bullets, i)
				
			end
		end
	end
	for i,v in pairs(enemies) do --printtaa viholliset
		love.graphics.draw(tileset, heads[v.dir], v.getPos()[1], v.getPos()[2])
		if love.math.random(1,5) ~=5 then
		v.walk()
		end
	end
	for i,v in pairs(guns) do
		love.graphics.draw(aseet, v[1].getQuad(), v[2]*32, v[3]*32,0, 0.7, 0.7)
		if px==v[2] and py==v[3] then
			OletusInv.setAse(v[1])
			if inventory.getGun(v[1]) then
			OletusInv.getGun(v[1]).setStorage(OletusInv.getGun(v[1]).getStorage()+v[4])
			else
			OletusInv.getGun(v[1]).setStorage(v[4])
			end
			guns[i]=nil
		end
	end
	if throwsign then --piirtää tekstin ala reunaan
		love.graphics.print(text, 5*ts, 16*ts, 0, 2, 2)
	end
	if map==defmap then --Tätä voit jatkaa mapeilla
		mapChange(23, 3, map2) --eli siis kaks ekaa numeroo on kohta missä vaihtuu mäppi ja sitten tulee map
		--mapit kannattaa tallentaa maps.lua tiedostoon jotta tästä tulee paljon luettavampi
	elseif map==map2 then
		mapChange(23, 3, map3)
	elseif map==map3 then
		mapChange(23, 3, map4)
	elseif map==map4 then
		mapChange(18,6, map5_7)
	elseif map==map5_7 then
		mapChange(3,3, map6)
		mapChange(3,11, map8)
	elseif map==map6 then
		mapChange(18,12, map5_7, {3, 13})
	end

end

function love.update(dt)
_G.dt = dt
cooldown=cooldown+dt
	if love.keyboard.isDown("a") and timer then--timer on sitä varten ettei kävele liian lujaa
		suunta=vasen
		if allowed[map[py][px-1]] then --tarkastaa onko vasemman puolimmainen tile sallittu
			opx=px
		if not love.keyboard.isDown("lshift") then
			timer=false
		end
		end
	elseif love.keyboard.isDown("d") and timer then
			suunta=oikea
			opx=px
		if allowed[map[py][px+1]] then --tarkastaa onko vasemman puolimmainen tile sallittu
			if not love.keyboard.isDown("lshift") then
			timer=false
			end
		end
	elseif love.keyboard.isDown("w") and timer then
			suunta=ylos
			opy=py
		if allowed[map[py-1][px]] then --tarkastaa onko vasemman puolimmainen tile sallittu
			if not love.keyboard.isDown("lshift") then
			timer=false
			end
		end
	elseif love.keyboard.isDown("s") and timer then
			suunta=alas
			opy=py
		if allowed[map[py+1][px]] then --tarkastaa onko vasemman puolimmainen tile sallittu
			if not love.keyboard.isDown("lshift") then
			timer=false
			end
		end
	end
	if not timer then
		if suunta==vasen then
			px=px-(0.2*dt*59)
			if px<=opx-1 then
			timer=true
			px=opx-1
			end
		end
		if suunta==oikea then
			px=px+(0.2*dt*59)
			if px>=opx+1 then
			timer=true
			px=opx+1
			end
		end
		if suunta==ylos then
			py=py-(0.2*dt*59)
			if py<=opy-1 then
				timer=true
				py=opy-1
			else
			end
		end
		if suunta==alas then
			py=py+(0.2*dt*59)
			if py>=opy+1 then
				timer=true
				py=opy+1
			else
			end
		end
	end
	if love.keyboard.isDown("space") and inventory.getBest().tyyli=="Rynnäkkökivääri" and cooldown>0.15 then
		inventory.getBest().shoot()
		cooldown=0
	elseif love.keyboard.isDown("space") and inventory.getBest().tyyli=="Konepistooli" and cooldown>0.05 then
		inventory.getBest().shoot()
	end
end
function love.focus(bool)
end

function love.keypressed( key, unicode )
	if key=="space" and inventory.getBest().tyyli=="Pistooli" then
		inventory.getBest().shoot()
	end
	if key=="e" then
		local tile, y, x = getNextTile(px, py, suunta)
		if tile==10 then
			map[y][x]=11
		end
	end
	if key=="r" then
		inventory.getBest().load()
	end
	if key=="1" then --Aseenvaihto 1=rynkky 2=konepistooli --3 pistooli
		inventory.getBest =	function()
		if inventory["Rynnäkkökivääri"]~=nil then
			return inventory["Rynnäkkökivääri"]
		end
		if inventory["Konepistooli"]~=nil then
			return inventory["Konepistooli"]
		end
		if inventory["Pistooli"]~=nil then
			return inventory["Pistooli"]
		end
			return puukko
	end
	elseif key=="2" then
		inventory.getBest=function()
		if inventory["Konepistooli"]~=nil then
			return inventory["Konepistooli"]
		end
		if inventory["Rynnäkkökivääri"]~=nil then
			return inventory["Rynnäkkökivääri"]
		end
		if inventory["Pistooli"]~=nil then
			return inventory["Pistooli"]
		end
			return puukko
		end
	elseif key=="3" then
		inventory.getBest=function()
		if inventory["Pistooli"]~=nil then
			return inventory["Pistooli"]
		end
		if inventory["Rynnäkkökivääri"]~=nil then
			return inventory["Rynnäkkökivääri"]
		end
		if inventory["Konepistooli"]~=nil then
			return inventory["Konepistooli"]
		end
			return puukko
		end
	end
	end


function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
print(px, py)
print(x.." "..y)
end

function love.mousereleased( x, y, button )
end

function love.quit()
end