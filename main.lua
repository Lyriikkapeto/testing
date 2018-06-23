require("aseet")
require("enemy")
require("maps")
function love.load()
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
	heads = {}--lataa tikkuukon päät
	for i=1, 4 do
		heads[i] = love.graphics.newQuad(ts*(10+i), 0, ts, ts, tileset:getDimensions())
	end
	allowed = {[2] = true, [1]=false, [3]=false, [4]=false, [5]=true, [6]=true, [7]=false, [8]=false, [0]=true}
	px, py = 3, 3 --pelaajan x ja y tileissä
	opx, opy = 3, 3 --muuttujat jotka tallentaa pelaajan position liikkumisen ajaksi
--älä välitä 
	ylos=4
	vasen=2
	alas=1
	oikea=3
--suuntien numero koodit
suunta=alas
timer=true--onko ajastus mennyt yli
counter=0 --laskee pikseletä kävelyssä
bullets={}
enemies={}
vihollinen=enemy(100, 5, 5, 0.1)
table.insert(enemies, vihollinen)
end
function tilePos(x,y)--oalauttaa oikean position mappiposition pohjalta
return ts*x, ts*y
end

function getNext(x,y, suunta) --tarkastaa onko seuraava tilee suunnassa vapaa
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
return false
end
function mapChange(x,y,newmap)
	if px==x and py==y then
		map=newmap
		opx, px=getmetatable(newmap).startpos[1], getmetatable(newmap).startpos[1]
		opy, py=getmetatable(newmap).startpos[2], getmetatable(newmap).startpos[2]
		bullets={}
		enemies=getmetatable(newmap).enemies
	end
end
function love.draw()

	
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
				if v[3]==oikea then v[1]=v[1]+1
				elseif v[3]==vasen then v[1]=v[1]-1 --kuvottavaa
				elseif v[3]==ylos then v[2]=v[2]-1
				elseif v[3]==alas then v[2]=v[2]+1 end
			else
				table.remove(bullets, i)
			end
		for a,b in pairs(enemies) do --huono ratkaisu. nostaa rankasti kompleksiteettia
			if b.x==v[1] and b.y==v[2] then
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
	
	if throwsign then --piirtää tekstin ala reunaan
		love.graphics.print(text, 5*ts, 16*ts, 0, 2, 2)
	end
	if map==defmap then --Tätä voit jatkaa mapeilla
		mapChange(23, 3, map2) --eli siis kaks ekaa numeroo on kohta missä vaihtuu mäppi ja sitten tulee map
		--mapit kannattaa tallentaa maps.lua tiedostoon jotta tästä tulee paljon luettavampi
	elseif map==map2 then
		mapChange(23, 3, map3)
	end

end

function love.update(dt)
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
			px=px-0.2
			if px<=opx-1 then
			timer=true
			px=opx-1
			end
		end
		if suunta==oikea then
			px=px+0.2
			if px>=opx+1 then
			timer=true
			px=opx+1
			end
		end
		if suunta==ylos then
			py=py-0.2
			if py<=opy-1 then
				timer=true
				py=opy-1
			else
			end
		end
		if suunta==alas then
			py=py+0.2
			if py>=opy+1 then
				timer=true
				py=opy+1
			else
			end
		end
	end
	
end
function love.focus(bool)
end

function love.keypressed( key, unicode )
	if key=="space" then
		inventory.getBest().shoot()
	end
	if key=="k" then
		table.insert(enemies, enemy(100, 6, 6, 0.1))
	end
	if key=="m" then--xd
		table.insert(enemies, monster(100, 6, 6, 0.1))
	end
	if key=="r" then
		inventory.getBest().load()
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