f = "./Example.txt"
lines = parse.(Int,readlines(f))
ans1 = length(findall(x->x>0,diff(lines)))
println("Part 1 answer = $ans1")

#end of part 1 

floor_mean = []
for i in 1:(length(lines)-2)
    push!(floor_mean,sum(lines[i:i+2]))
end
ans2 = length(findall(x->x>0,diff(floor_mean)))
println("Part 1 answer = $ans2")