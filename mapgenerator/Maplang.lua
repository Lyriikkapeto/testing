-----Loadaa tiedostosta mäpin metadataa---
---Tällä hetkellä pystyy lataamaan aloituskohtia ja vihollisia----

coords="%(%d+,%d+%)"
mapcoords="->(.+),(%s*)(%d+)(%s*),(%s*)(%d+)"
meta={startpos={}, enemies={}}
tmpst={}
tmpenem={}
file = io.open("map.txt","a")
for line in io.lines("map.txt") do
	if line:find("Aloituskohta") then
		tmpst = {string.match(line, coords)}
	elseif line:find("Viholliset") then
		for v in string.gmatch(line, coords) do
		x=v:match("%(%d+")
		x=x:match("%d+")
		y=v:match("%d+%)")
		y=y:match("%d+")
			table.insert(tmpenem, {tonumber(x),tonumber(y)})
		end
	elseif line:find("map") then
		--todo
	end
end
print(meta.startpos, meta.enemies[1])
for i,v in pairs(tmpst) do
		table.insert(meta.startpos, tonumber(string.match(v, "%d+")))
end
for i,v in pairs(tmpenem) do
	table.insert(meta.enemies, {dangerenemy, v[1], v[2]})
end

io.read()