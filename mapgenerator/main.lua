function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function love.load()
wholestring = {}
	map = {
	{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},--1
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},--7
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}--15
	}
	
map = {
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},--max x=25
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,1},
{1,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,6,1},
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
map ={
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,2,2,2,3,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,2,2,4,2,1},
{1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,2,2,2,4,2,4,2,1},
{1,3,3,3,4,2,2,2,4,4,4,4,4,4,2,2,4,2,2,2,4,2,4,2,1},
{1,2,2,2,3,3,3,2,3,3,3,3,3,3,2,2,4,2,2,2,4,2,3,2,1},
{1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,2,2,2,4,2,10,2,1},
{1,2,2,2,4,3,4,2,4,3,4,3,3,2,2,2,4,2,2,2,4,2,4,2,1},
{1,3,3,3,3,2,4,2,4,2,4,2,2,4,2,2,4,2,2,2,4,2,4,2,1},
{1,2,2,2,2,2,3,2,3,3,3,2,2,3,3,2,3,3,2,2,3,2,4,2,1},
{1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,2,1},
{1,2,2,3,3,3,3,3,3,3,3,2,2,3,4,2,4,3,3,3,3,3,3,2,1},
{1,2,2,2,2,2,8,2,8,2,2,3,3,2,3,2,4,5,2,2,2,2,2,2,1},
{1,2,2,2,2,2,8,2,8,2,2,2,2,2,2,2,4,2,2,2,2,2,2,2,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}
	tileset = love.graphics.newImage("tileset.png")
	ts=32
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
	quads[9] = love.graphics.newQuad(320, 416, ts, ts, tileset:getDimensions())--harmaa
	quads[10]=love.graphics.newQuad(96, 230, ts, ts, tileset:getDimensions()) --ovi
end


function love.draw()
for i in ipairs(map) do
for q in ipairs(map[i]) do
love.graphics.draw(tileset, quads[map[i][q]], q*32, i*32)
end
end
end
function love.update(dt)

end
function love.focus(bool)
end


function love.keypressed( key, unicode )
if key == "1" then
for i, b in ipairs(map) do
table.insert(map[i], 1)
end
end
if key == "2" then
temptable = {}
for i=1, table.maxn(map[1]) do
table.insert(temptable, 1)
end
table.insert(map, temptable)
end
if key == "s" then
stringg = table.tostring(map)
stringg = string.gsub(stringg, "{", "\n{")
love.system.setClipboardText(stringg)
end
end


--[[if key == "w" then
movecamera(0, -1)
elseif key == "s" then
movecamera(0, 1)
elseif key == "a" then
movecamera(-1, 0)
elseif key == "d" then
movecamera(1, 0)
end]]

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
posx = math.floor(x/32)
posy = math.floor(y/32)
if button==3 then
	print(posx,posy)
end
if quads[map[posy][posx]+1] ~= nil and button == 1 then
map[posy][posx] = map[posy][posx]+1 
elseif button == 1 then
map[posy][posx] = 0
end
if quads[map[posy][posx]-1] ~= nil and button == 2 then
map[posy][posx] = map[posy][posx]-1
elseif button == 2 then
map[posy][posx] = table.maxn(quads)
end
--print(x.." "..y)
end

function love.mousereleased( x, y, button )
end

function love.quit()
end