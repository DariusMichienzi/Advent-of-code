f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day14Data.txt"
lines = readlines(f)
coords = parse.(Int,hcat(split.((chop.(hcat(split.(lines," ")...)[1,:],head=2,tail=0)),",")...))
velocity = parse.(Int,hcat(split.((chop.(hcat(split.(lines," ")...)[2,:],head=2,tail=0)),",")...))

x = 101
y = 103

sizes = (x,y)

finalcoord = mod.(coords .+ 100*velocity,sizes)

quad1 = length(finalcoord[:,(finalcoord[1, :].<(x-1)÷2).&&(finalcoord[2, :].<(y-1)÷2)][1,:])
quad2 = length(finalcoord[:,(finalcoord[1, :].>(x-1)÷2).&&(finalcoord[2, :].<(y-1)÷2)][1,:])
quad3 = length(finalcoord[:,(finalcoord[1, :].>(x-1)÷2).&&(finalcoord[2, :].>(y-1)÷2)][1,:])
quad4 = length(finalcoord[:,(finalcoord[1, :].<(x-1)÷2).&&(finalcoord[2, :].>(y-1)÷2)][1,:])

ans1 = quad1*quad2*quad3*quad4

println("part 1 answer = ",ans1)
#end of part 1

using Distances
using Statistics

dist = []
for t in 1:10000
    timecoord = mod.(coords .+ t*velocity,sizes)
    distances = pairwise(Euclidean(), timecoord, dims=2)
    push!(dist,mean(distances))
end

ans2 = findfirst(x->x==minimum(dist),dist)

println("part 2 answer = ",ans2)

##below is the code to plot of the image to check it is actually the solution
using Plots

eggcoord = mod.(coords .+ (ans2)*velocity,sizes)

mat = Int.(zeros(sizes))

for i in eachindex(eggcoord[1,:])
    mat[eggcoord[1,i]+1,eggcoord[2,i]+1] += 1
end
plot(heatmap(rotl90(mat)))
plot(dist)