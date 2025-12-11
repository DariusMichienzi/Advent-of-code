f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day20Data.txt"
lines = readlines(f)
list = [if i<=length(line) line[i] else "" end for line in lines for i in length(lines):-1:1]
data = rotr90(reshape(list,length(lines),length(lines)))

start = Tuple.(findfirst(data.=='S'))
finish = Tuple.(findfirst(data.=='E'))
walls = findall(data.=='#')
directions = [(0,1),(1,0),(0,-1),(-1,0)]

map = zeros(Int, size(data))
for coord in walls
    map[coord] = -1
end
maptest = copy(map)

function steps(data)
    tests = [start]
    while length(tests) !== 0 
        current = popfirst!(tests)
        for d in directions
            if get(data,current.+d,NaN) == 0 || get(data,current.+d,NaN) > get(data,current,NaN)+1
                push!(tests,(current.+d))
                data[CartesianIndex(current.+d)] = data[CartesianIndex(current)]+1
            end
        end
    end
    return data[CartesianIndex(finish)]
end
t0 = steps(map)
map[CartesianIndex(start)] = 0

function taxicab(coord, distance, sizes)
    cx, cy = coord
    x, y = sizes
    coordinates = []
    for dx in -distance:distance
        dy = distance - abs(dx) 
        if cx + dx in 1:x && cy + dy in 1:y
            push!(coordinates, (cx + dx, cy + dy))
        end
        if dy != 0 && cx + dx in 1:x && cy - dy in 1:y
            push!(coordinates, (cx + dx, cy - dy))
        end
    end
    return coordinates
end

tests = [finish]
path = [finish]
while length(tests) !== 0 
    current = popfirst!(tests)
    for d in directions
        if get(map,current.+d,NaN) == get(map,current,NaN) - 1 && get(map,current.+d,NaN) != -1
            push!(tests,(current.+d))
            push!(path,(current.+d))
        end
    end
end

function timesaved(distance)
    timesave = []
    for step in path
        for dist in 2:distance
            testcoord = taxicab(step,dist,size(data))
            for coord in testcoord
                if map[CartesianIndex(coord)] != -1 && map[CartesianIndex(step)] + dist  < map[CartesianIndex(coord)]
                    saved = map[CartesianIndex(coord)] - (map[CartesianIndex(step)] + dist)
                    push!(timesave,saved)
                end
            end
        end
    end
    return timesave
end

timesaved1 = timesaved(2)
ans1 = length(findall(timesaved1 .>= 100))
println("part 1 answer = ",ans1)

# end of part 1 

timesaved2 = timesaved(20)
ans2 = length(findall(timesaved2 .>= 100))
println("part 2 answer = ",ans2)