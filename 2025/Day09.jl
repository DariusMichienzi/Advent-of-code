f = "./DataFiles/Day09.txt"
lines = split.(readlines(f),",")
coords = [parse.(Int,line) for line in lines]
ans1 = 0
for i in eachindex(coords)
    for j in eachindex(coords)
        if !(i==j)
            area = (abs(coords[i][1] - coords[j][1]) + 1)*(abs(coords[i][2] - coords[j][2]) + 1)  
            if area > ans1
                global ans1 = area
            end
        end
    end
end
println("Part 1 answer = $ans1")

#end of part 1
using Combinatorics, ProgressMeter

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
    global edge = [edge;edgeneg]
else
    global edge = [edge;edgepos]
end
end

edgeposend = vec(collect(corns[end]:CartesianIndex(1,1):corns[1]))[2:end-1]
edgenegend = vec(collect(corns[end]:CartesianIndex(-1,-1):corns[1]))[2:end-1]
if isempty(edgeposend)
    global edge = [edge;edgenegend]
else
    global edge = [edge;edgeposend]
end

ans2 = 0 
K = collect(combinations(corns, 2))
@showprogress for k in K
    coord1 = k[1]
    coord2 = k[2]
    a1, a2 = minimum([coord1[1],coord2[1]]) , maximum([coord1[1],coord2[1]])
    b1, b2 = minimum([coord1[2],coord2[2]]) , maximum([coord1[2],coord2[2]])
    area = (abs(coord1[1] - coord2[1]) + 1)*(abs(coord1[2] - coord2[2]) + 1) 
        if area > ans2
            available = true
            Threads.@threads for E in edge
                if available && a1 < E[1] < a2 && b1 < E[2] < b2
                    available = false
                end
            end
            if available == true
                global ans2 = area
            end
        end
end

println("Part 2 answer = $ans2")
#this used to take ~117 seconds now It's ~14 so I'm proud of that improvement  