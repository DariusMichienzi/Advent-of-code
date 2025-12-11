using Graphs
using MetaGraphsNext
f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day23Data.txt"
lines = readlines(f)
graph = MetaGraph(SimpleGraph(), String)
for line = lines
    connection = split(line, '-')
    add_vertex!(graph, connection[1])
    add_vertex!(graph, connection[2])
    add_edge!(graph, connection[1], connection[2])
end

cycles = simplecycles_limited_length(graph, 3)
filter!(x->length(x) == 3, cycles)
filt = unique!(sort!.(cycles))

ans1 = 0 
for cycle in filt
    tees = 0
    for i in cycle
        if label_for(graph,i)[1] == 't'
            tees += 1
            continue
        end
    end
    if tees >=1
        ans1+=1
    end
end

println("part 1 answer = ",ans1)

#end of part 1 

ind = findfirst(x->x==maximum(length.(maximal_cliques(graph))),length.(maximal_cliques(graph)))
largest = maximal_cliques(graph)[ind]
computers = []
for index in largest
    push!(computers,label_for(graph,index))
end
ans2 = join(sort!(computers),",")
println("part 2 answer = ",ans2)