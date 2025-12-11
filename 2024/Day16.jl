f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day16Data.txt"
lines = readlines(f)
list = [if i<=length(line) line[i] else "" end for line in lines for i in length(lines):-1:1]
data = rotr90(reshape(list,length(lines),length(lines)))

directions =[[(0, 1, 0),(0, 0, -1),(0, 0, 1)],
[(1, 0, 0),(0, 0, -1),(0, 0, 1)],
[(0, -1, 0),(0, 0, -1),(0, 0, 1)],
[(-1, 0, 0),(0, 0, -1),(0, 0, 1)],]

start = findfirst(data.=='S')
finish = findfirst(data.=='E')

A = (zeros(Int,size(data)[1],size(data)[2], 4))
walls = findall(data.=='#')
for i in walls
    for k in 1:4
        A[i[1],i[2],k] = -1
end 
end

coords = [(finish[1],finish[2],1),(finish[1],finish[2],2),(finish[1],finish[2],3),(finish[1],finish[2],4)]
change = [1,1000,1000]

while length(coords) !== 0 
    test = popfirst!(coords)
    i = test[3]
    for j in 1:3
    newcoord = mod1.(test.+directions[i][j],size(A))
    if get(A,newcoord,NaN) == 0 ||  get(A,newcoord,NaN) > get(A,test,NaN)+change[j]
        A[CartesianIndex(newcoord)] = A[CartesianIndex(test)]+change[j]
        push!(coords,newcoord)
    end
end
end

ans1 = minimum(A[start[1],start[2],:])
println("part 1 answer = ",ans1)
#end of part 1 
visits = falses(size(A))
coords = [(start[1],start[2],1)]

visits[CartesianIndex(coords[1])] = true

while length(coords) !== 0 
    test = popfirst!(coords)
    i = test[3]
    for j in 1:3
    newcoord = mod1.(test.-directions[i][j],size(visits))
    if !visits[CartesianIndex(newcoord)] && A[CartesianIndex(newcoord)] + change[j]== A[CartesianIndex(test)] 
        visits[CartesianIndex(newcoord)] = true
        push!(coords,newcoord)
    end
end
end

a = findall(visits[:,:,1].==1)
append!(a,findall(visits[:,:,2].==1))
append!(a,findall(visits[:,:,3].==1))
append!(a,findall(visits[:,:,4].==1))
ans2 = length(unique!(a))
println("part 2 answer = ",ans2)