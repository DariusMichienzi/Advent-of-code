f = "./DataFiles/Day03.txt"
lines = readlines(f)
ans1 = 0

for line in lines 
line = parse.(Int,split(line,""))
    combinations = Int[]
for i in 1:(length(line)-1)
    push!(combinations,10*line[i]+maximum(line[i+1:end]))
end

ans1 += maximum(combinations)
end

println("Part 1 answer = $ans1")

# end of part 1

ans2 = 0
N_dig = 12
for line in lines 
    total = 0
    line = parse.(Int,split(line,""))
    index = 0
    for i in (N_dig-1):-1:0
        index += argmax(line[index+1: end-i])
        total = parse(Int,string(total,line[index]))
    end
    ans2 += total
end

println("Part 2 answer = $ans2")