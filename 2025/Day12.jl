f = "./DataFiles/Day12.txt"
lines = readlines(f)
findall(x->x=="",lines)

gridsizes = split.(lines[findall(x->x=="",lines)[end]+1:end],": ")
boxes = prod(lines[1:findall(x->x=="",lines)[end]])
boxsize = [length(findall(x->x=='#',boxes[start:start+9])) for start in findall(x->x==':',boxes)]

ans1 = 0 
for grid in gridsizes
totalgridsize = prod(parse.(Int,split(grid[1],"x")))
totalboxsize = sum(parse.(Int,split(grid[2]," ")).*boxsize)
if totalgridsize >= totalboxsize
    global ans1 += 1
end
end
println("Part 1 answer = $ans1")
#this was not a satisfying solution but an initial guess that turned out to be correct. This may not be reproducible for all inputs but its worked now and I can't go back ¯\_(ツ)_/¯