f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day10Data.txt"
lines = readlines(f)
list = [if i<=length(line) line[i] else "" end for line in lines for i in 1:length(lines)]
data = parse.(Int,rotr90(reshape(list,length(lines),length(lines))))

starts = findall(x->x==0,data)
directions = [CartesianIndex(1,0),CartesianIndex(-1,0),CartesianIndex(0,1),CartesianIndex(0,-1)]

ans1 = 0
ans2 = 0
for c in starts 
    coords = []
    push!(coords, [c])
    failed = false
    k = 1
    while failed == false && k!=10
        temp = []
        for l in coords[k]
            for d in directions
                if checkbounds(Bool, data, l+d) == true && data[l+d] == k 
                    push!(temp , CartesianIndex(l+d))
                end
            end
        end
        if length(temp) == 0 
            failed = true
        else
            push!(coords,temp)
        end
        k +=1 
    end
    ans1 += length(unique(coords[end]))
    ans2 += length(coords[end])
end

println("part 1 answer = ",ans1)

#end of part 1

println("part 2 answer = ",ans2)