f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day12Data.txt"
lines = readlines(f)
list = [if i<=length(line) line[i] else "" end for line in lines for i in 1:length(lines)]
data = reshape(list,length(lines),length(lines))

directions = [CartesianIndex(0,1),CartesianIndex(1,0),CartesianIndex(0,-1),CartesianIndex(-1,0)]
added = falses(length(lines),length(lines))

ans1 = 0
ans2 = 0
for i in CartesianIndices(data)
if added[i] == false
crop = [i]
added[i] = true
area = 0
perimiter = 0
edges = 0
while length(crop) != 0
    test = popfirst!(crop)
    neighbours = 0 
    vertecies = 0 
    for i in 1:4
        if get(data, test+directions[i], ' ') == data[test]
            neighbours += 1 
            if added[test+directions[i]]==false
                push!(crop,test+directions[i])
                added[test+directions[i]]=true
            end
        end
        edge1 = get(data, test+directions[i], ' ')
        edge2 = get(data, test + directions[1+i%4], ' ')
        corner = get(data, test + directions[i]+directions[1+i%4], ' ')
        if data[test] != edge1 && data[test] != edge2 || data[test] == edge1 == edge2 != corner
            vertecies += 1
        end
    end
    area += 1
    edges += vertecies
    perimiter += (4-neighbours)
end
ans1 += area*perimiter
ans2 += area*edges
end
end

println("part 1 answer = ",ans1)

#end of part 1 

println("part 2 answer = ",ans2)