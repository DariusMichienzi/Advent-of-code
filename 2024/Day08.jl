using Combinatorics
f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day8Data.txt"
lines = reverse(readlines(f))
list = [if i<=length(line) line[i] else "" end for line in lines for i in 1:length(lines)]
data = rotl90(reshape(list,length(lines),length(lines)))

freqs = unique(data[findall(x->x!='.',data)])
nodes = []
for i in eachindex(freqs)
pairs = collect(combinations(findall(x->x==freqs[i],data), 2))
for j in eachindex(pairs)
node1 = 2*pairs[j][2]-pairs[j][1]
node2 = 2*pairs[j][1]-pairs[j][2]
if checkbounds(Bool, data, node1) == true 
    push!(nodes,node1)
end
if checkbounds(Bool, data, node2) == true 
    push!(nodes,node2)
end
end
end

ans1 = length(unique(nodes))
println("part 1 answer = ",ans1)

#end of part 1

nodes2 = []
for i in eachindex(freqs)
pairs = collect(combinations(findall(x->x==freqs[i],data), 2))
for j in eachindex(pairs)
    diff  = pairs[j][2]-pairs[j][1]
    node1 =  pairs[j][2]
    node2 =  pairs[j][1]
    while checkbounds(Bool, data, node1) == true   
    push!(nodes2,node1)
        node1 += diff
    end
    while checkbounds(Bool, data, node2) == true
        push!(nodes2,node2)
        node2 -= diff
    end
    end
end

ans2 = length(unique(nodes2))
println("part 2 answer = ",ans2)