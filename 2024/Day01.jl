f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day1Data.txt"
lines = readlines(f)

col1 = Int[]
col2 = Int[]
for i in eachindex(lines)
numbers = parse.(Int,split(lines[i],"   "))
push!(col1,numbers[1])
push!(col2,numbers[2])
end
ans1 = sum(abs.(sort(col1).-sort(col2)))
println("part 1 answer = ",ans1)

#end of part 1 

ans2=0
for i in eachindex(col1)
    for j in eachindex(col2)
        a=0
        if col1[i] == col2[j]
            a += 1
        end
        ans2 += a*col1[i]
    end
end
println("part 2 answer = ",ans2)