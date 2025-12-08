using Distances, Graphs, MetaGraphsNext, GraphPlot, LinearAlgebra

f = "./DataFiles/Day08.txt"
lines = split.(readlines(f),",")

graph = MetaGraph(SimpleGraph(),Vector{Int64})
coords = [parse.(Int,line) for line in lines]

for coord in coords
    add_vertex!(graph, coord)
end

distances = UpperTriangular(pairwise(Euclidean(), coords))
dist = Dict()
for x in eachindex(distances)
    dist[distances[x]] = x
end
delete!(dist, 0.0)

for i in 1:1000
    connects = dist[minimum(keys(dist))]
    delete!(dist, minimum(keys(dist)))
    add_edge!(graph, coords[connects[1]], coords[connects[2]])
end

ans1 = prod(sort(length.(filter(x->length(x) > 1,connected_components(graph))),rev=true)[1:3])
println("Part 1 answer = $ans1")
gplot(graph)

#end of part 1

while !(length(connected_components(graph)) == 1)
    global connects = dist[minimum(keys(dist))]
    delete!(dist, minimum(keys(dist)))
    add_edge!(graph, coords[connects[1]], coords[connects[2]])
end

ans2 = coords[connects[1]][1] * coords[connects[2]][1]
println("Part 2 answer = $ans2")
gplot(graph)

#part 1 ~20s
#part 2 ~110s
# total ~130s