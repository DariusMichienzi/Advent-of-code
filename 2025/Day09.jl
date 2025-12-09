@time begin
f = "./DataFiles/Day09.txt"
lines = split.(readlines(f),",")
coords = [parse.(Int,line) for line in lines]
maxarea = 0
for i in eachindex(coords)
    for j in eachindex(coords)
        if !(i==j)
            area = (abs(coords[i][1] - coords[j][1]) + 1)*(abs(coords[i][2] - coords[j][2]) + 1)  
            if area > maxarea
                maxarea = area
            end
        end
    end
end
ans1 = maxarea
println("Part 1 answer = $ans1")

#end of part 1

Threads.nthreads() = 25 #using multithreading to speed this up because it takes too long otherwise 
corns = []
for coord in coords
push!(corns,CartesianIndex(coord[1],coord[2]))
end
edge = [corns[1]]

for i in 1:(length(corns)-1)
edgepos = vec(collect(corns[i]:CartesianIndex(1,1):corns[i+1]))[2:end]
edgeneg = vec(collect(corns[i]:CartesianIndex(-1,-1):corns[i+1]))[2:end]
if isempty(edgepos)
    edge = [edge;edgeneg]
else
    edge = [edge;edgepos]
end
end

edgeposend = vec(collect(corns[end]:CartesianIndex(1,1):corns[1]))[2:end-1]
edgenegend = vec(collect(corns[end]:CartesianIndex(-1,-1):corns[1]))[2:end-1]
if isempty(edgeposend)
    edge = [edge;edgenegend]
else
    edge = [edge;edgeposend]
end

areas = []
done = 0
total = binomial(length(corns),2)
for i in eachindex(corns)
    for j in eachindex(corns)
        if !(i==j)
            a1, a2 = minimum([corns[i][1],corns[j][1]]) , maximum([corns[i][1],corns[j][1]])
            b1, b2 = minimum([corns[i][2],corns[j][2]]) , maximum([corns[i][2],corns[j][2]])
            area = (abs(corns[i][1] - corns[j][1]) + 1)*(abs(corns[i][2] - corns[j][2]) + 1) 
            available = true
            Threads.@threads for E in edge
                if a1 < E[1] < a2 && b1 < E[2] < b2 && !(available == false)
                    available = false
                end
            end
            if available == true
            push!(areas,area)
            end
        end
        done += 1
        println("Finished rectangle $done ")
    end
end

ans2 = maximum(areas)
println()
println("Part 1 answer = $ans1")
println("Part 2 answer = $ans2")
end