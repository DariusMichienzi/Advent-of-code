f = "./Day01.txt"
lines = parse.(Int,readlines(f))

for line in eachindex(lines)
    C = 2020 - line
    if isempty(findall(x->x==C,lines)) == false
        global ans1 = line * C
    end
end

println("part 1 answer = $ans1")

##end of part 1 

for i in eachindex(lines)
    for j in eachindex(lines)
        for k in eachindex(lines)
            if i!=j&& j!=k && lines[i] + lines[j] + lines[k] == 2020
                global ans2 = lines[i] * lines[j] * lines[k]
            end
        end
    end
end

println("part 2 answer = $ans2")
