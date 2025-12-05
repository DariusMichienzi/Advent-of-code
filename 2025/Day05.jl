f = "./DataFiles/Day05.txt"
lines = readlines(f)
brk = findfirst(x->x=="",lines)
goodId = lines[1:brk-1]
Food = parse.(Int,lines[brk+1:end])
goodId = parse.(Int,mapreduce(permutedims,vcat,split.(goodId,"-")))

ans1 = 0
for F in Food
    for R in eachrow(goodId)
        if F >= R[1] && F<=R[2]
        ans1+=1
        break
        end
    end
end
println("Part 1 answer = $ans1")

#end of part 1

allId = deepcopy(goodId)
allId = sortslices(allId, dims=1)
ans2 = 0
i = 1
while i <= length(allId[:,1])
    (bottom,top) = allId[i,:]
    i += 1
    while i <= length(allId[:,1]) && allId[i,1] <= top
        top = max(top, allId[i,2])
        i += 1
    end
    ans2 += length(range(bottom,top))
end
println("Part 2 answer = $ans2")