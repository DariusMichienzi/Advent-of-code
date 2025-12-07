f = "./DataFiles/Day07.txt"
lines = readlines(f)
data = mapreduce(permutedims,vcat,split.(lines,""))

paths = zeros(Int,axes(data))
beam = [findfirst(x->x=="S",data)]
paths[beam[1]] = 1
ans1 = 0

while !(length(beam) == 0)
path = popfirst!(beam)
if get(data,path + CartesianIndex(1,0),"!") == "."
    push!(beam,path + CartesianIndex(1,0))
    paths[path + CartesianIndex(1,0)] += paths[path]
elseif get(data,path + CartesianIndex(1,0),"!") == "^"
    push!(beam,path + CartesianIndex(1,1))
    push!(beam,path + CartesianIndex(1,-1))
    paths[path + CartesianIndex(1,1)] += paths[path]
    paths[path + CartesianIndex(1,-1)] += paths[path]
    ans1 +=1
end
unique!(beam)
end

println("Part 1 answer = $ans1")

ans2 = sum(eachrow(paths)[end])
println("Part 2 answer = $ans2")
