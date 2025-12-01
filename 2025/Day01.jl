f = "./DataFiles/Day01.txt"
lines = readlines(f)

direction = []
numbers = []
for line in lines
    push!(direction,line[1])
    push!(numbers,line[2:end])
end
numbers = parse.(Int,numbers)

pos = [50]
for i in eachindex(numbers)
    if direction[i] == 'L'
        push!(pos, mod(pos[i] - numbers[i] , 100))
    elseif direction[i] == 'R'
        push!(pos, mod(pos[i] + numbers[i] , 100))
    end
end
ans1 = length(findall(x->x==0,pos))
println("Part 1 answer = $ans1")

#end of part 1

pos = [50]
visit = []
for i in eachindex(numbers)
    if direction[i] == 'L'
        push!(pos, mod(pos[i] - numbers[i] , 100))
        visit = [visit;mod.(collect(pos[i]:-1:pos[i] - numbers[i]),100)]
    elseif direction[i] == 'R'
        visit = [visit;mod.(collect(pos[i]:1:pos[i] + numbers[i]),100)]
        push!(pos, mod(pos[i] + numbers[i] , 100))
    end
end

ans2 = length(findall(x->x==0,visit)) - length(findall(x->x==0,pos))
println("Part 2 answer = $ans2")