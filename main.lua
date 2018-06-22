require("aseet")


function love.load()
	inventory = OletusInv
	map = {
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}
	tileset = love.graphics.newImage("tileset.png")
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
end
function tilePos(x,y)--oalauttaa oikean position mappiposition pohjalta
return ts*x, ts*y
end

function love.draw()

	for y,xtaulukko in pairs(map) do --Piirtää mapin
		for x,quadnumero in pairs(xtaulukko) do
			love.graphics.draw(tileset, quads[quadnumero], x*ts, y*ts)
		end
	end
	
	love.graphics.draw(tileset, heads[suunta], px*ts, py*ts)
	if suunta==oikea then
	love.graphics.draw(aseet, inventory.getBest().getQuad(), px*ts+16, py*ts+16, 0, 0.5, 0.5)
	elseif suunta==vasen or suunta==alas then
	love.graphics.draw(aseet, inventory.getBest().getQuad(), px*ts+16, py*ts+16, 0, -0.5, 0.5)
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