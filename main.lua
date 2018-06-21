

function love.load()

	map = {
{4,3,3,3,3,3,4,4,3,4,4,4,8,8,8,8,8,8,8,8,8,8,8,8,8},
{4,2,2,2,2,2,3,3,8,3,3,4,6,6,6,6,6,6,6,6,6,6,6,6,8},
{4,2,2,2,2,2,2,6,6,6,6,4,6,6,6,6,6,6,6,6,6,6,6,6,8},
{4,2,2,2,2,2,2,6,6,6,6,4,6,6,6,6,6,6,8,6,6,6,6,6,8},
{3,3,3,3,3,3,4,6,6,6,6,4,0,0,0,0,6,0,0,0,0,0,0,6,8},
{0,0,0,0,0,0,4,4,8,4,4,4,0,6,0,6,0,8,6,0,0,6,0,0,8},
{0,4,3,3,3,3,3,3,6,4,4,4,0,0,0,0,6,0,0,0,6,8,0,0,8},
{0,4,2,5,5,5,5,2,2,2,4,0,0,0,0,6,0,0,0,0,0,0,0,0,8},
{0,4,2,5,5,5,5,2,2,2,4,0,0,5,0,0,0,6,5,0,0,6,0,0,8},
{0,4,2,5,5,5,5,2,2,2,4,0,0,0,0,0,0,0,0,0,0,8,0,0,8},
{0,4,2,4,3,3,3,3,3,3,3,0,0,0,0,0,6,0,0,0,6,0,0,0,8},
{0,4,2,2,6,6,6,6,6,6,6,6,6,6,6,0,0,6,0,8,0,0,7,0,8},
{0,2,2,2,6,6,6,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,8},
{1,3,3,3,3,3,3,3,3,3,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
{1,3,3,3,3,3,3,3,3,3,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
{1,3,3,3,3,3,3,3,3,3,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8}}
	tileset = love.graphics.newImage("tileset.png")
	ts=32
	mw=16
	mh=5
	quads = {}
	quads[0] = love.graphics.newQuad(ts*0, 0, ts, ts, tileset:getDimensions())--tyhjyys
	quads[1] = love.graphics.newQuad(ts*8, 0, ts, ts, tileset:getDimensions())--tiiliseinä
	quads[2] = love.graphics.newQuad(ts*1, 0, ts, ts, tileset:getDimensions())--maa
	quads[3] = love.graphics.newQuad(ts*9, 0, ts, ts, tileset:getDimensions())--tiili
	quads[4] = love.graphics.newQuad(ts*10, 0, ts, ts, tileset:getDimensions())--tiili
	quads[5] = love.graphics.newQuad(ts*0, ts*21, ts, ts, tileset:getDimensions())--tiheäruoho
	quads[6] = love.graphics.newQuad(ts*0, ts*20, ts, ts, tileset:getDimensions())--nurmikko
	quads[7] = love.graphics.newQuad(448, 443, ts, ts, tileset:getDimensions())--tyyppi
	quads[8] = love.graphics.newQuad(ts*4, ts*20, ts, ts, tileset:getDimensions())--oksa
	allowed = {[2] = true, [1]=false, [3]=false, [4]=false, [5]=true, [6]=true, [7]=false, [8]=false, [0]=true}
	heads = {}
	for i=1, 4 do
	heads[i] = love.graphics.newQuad(ts*(10+i), 0, ts, ts, tileset:getDimensions())
	heads[i+0.5] = love.graphics.newQuad(ts*(10+i), 0, ts, ts-10, tileset:getDimensions())
	end
	camera = love.graphics.newSpriteBatch(tileset, mw*mh)
	camerax = 1
	cameray = 1
	updatecamera()
end

function updatecamera()
camera:clear()
  for x=0, mw do
    for y=0, mh do
	if map[y+cameray] ~=nil and map[y+cameray][x+camerax]~=nil then--look for fix
	--print(y+cameray.." "..x+camerax)
      camera:add(quads[map[y+cameray][x+camerax]], x*ts, y*ts)
    end
  end
  end
  camera:flush()
end--x+camerax][y+cameray]],

function love.draw()

love.graphics.draw(camera)
end

function love.update(dt)
end
function love.focus(bool)
end
function movecamera(x, y)

camerax = camerax+x
cameray = cameray+y
updatecamera()
end

function love.keypressed( key, unicode )

end


function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
print(x.." "..y)
end

function love.mousereleased( x, y, button )
end

function love.quit()
end
return info