f = "./DataFiles/Day04.txt"
lines = readlines(f)
rows = []
for line in lines
    push!(rows, split(line,""))
end
data = mapreduce(permutedims,vcat,rows)

surround = [CartesianIndex(-1,-1),CartesianIndex(-1,0),CartesianIndex(-1,1),CartesianIndex(0,-1),CartesianIndex(0,1),CartesianIndex(1,-1),CartesianIndex(1,0),CartesianIndex(1,1)]

rolls = findall(x->x=="@",data)
ans1 = 0 
for roll in rolls
    S = 0 
    for C in surround
        if get(data,roll+C,".") == "@"
            S += 1
        end
    end
    if S < 4
        global ans1+=1
    end
end
println("Part 1 answer = $ans1")
# end of part 1 
global shelf = deepcopy(data)

ans2 = 0 
changed = true 

while changed
    global rolls = findall(x->x=="@",shelf)
    global changed = false
    for roll in rolls
        S = 0 
        for C in surround
            if get(shelf,roll+C,".") == "@"
                S += 1
            end
        end
        if S < 4
            global ans2 += 1
            shelf[roll] = "."
            changed = true
        end
    end
end
println("Part 2 answer = $ans2")

## Interested to see what the final shelf looks like once all rolls are taken  
output = "FinalShelf.txt"
open(output, "w") do file
    for row in eachrow(shelf)
        println(file, join(row, ""))
    end
end