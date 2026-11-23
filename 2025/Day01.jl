f = "./DataFiles/Day01.txt"
lines = readlines(f)

direction = []
numbers = []
for line in lines
    push!(direction,line[1])
    push!(numbers,line[2:end])
end
numbers = parse.(Int,numbers)

pos = 50
ans1 = 0
ans2 = 0
for i in eachindex(numbers)
    if direction[i] == 'L'
        visit = mod.(collect(pos:-1:pos - numbers[i]),100)
        global pos = mod(pos - numbers[i],100)
    elseif direction[i] == 'R'
        visit = mod.(collect(pos:1:pos + numbers[i]),100)
        global pos = mod(pos + numbers[i],100)
    end
    
    global ans1 += visit[1] == 0 ? 1 : 0 
    global ans2 += length(findall(x->x==0,visit))
end

ans2 -= ans1
println("Part 1 answer = $ans1")
println("Part 2 answer = $ans2")