f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day18Data.txt"
lines = readlines(f)
coords = [((parse(Int,line[1]),parse(Int,line[2]))) for line in split.(lines,",")]

sizes = (70,70)
memory = fill(0,sizes.+(1,1))

for i in 1:1024
    memory[CartesianIndex(coords[i].+(1,1))] = -1
end

start = (1,1)
finish = sizes.+(1,1)
directions = [(0,1),(1,0),(0,-1),(-1,0)]

function steps(mem)
    memory = copy(mem)
    tests = [start]
    while length(tests) !== 0 
        current = popfirst!(tests)
        for d in directions
            if get(memory,current.+d,NaN) == 0 || get(memory,current.+d,NaN) > get(memory,current,NaN)+1
                push!(tests,(current.+d))
                memory[CartesianIndex(current.+d)] = memory[CartesianIndex(current)]+1
            end
        end
    end
    return memory[CartesianIndex(finish)]
end
ans1 = steps(memory)
println("part 1 answer = ",ans1 )

# end of part 1 

memory2 = copy(memory)
ans2 = 0
for c in coords[1025:end]
    memory2[CartesianIndex(c.+(1,1))] = -1
    if steps(memory2) == 0 
        ans2 = c
       break
    end
end

println("part 2 answer = ",ans2)