using IterTools
f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day7Data.txt"
lines = readlines(f)

indicies = Int[]
for i in eachindex(lines)
dataline  = split(lines[i]," ")
result = parse(Int,chop(dataline[1],tail=1))
numbers = parse.(Int,dataline[2:length(dataline)])
mat = collect(IterTools.product(fill(["+","*"], (length(numbers)-1))...))
ops = reshape(mat,(length(mat),1))
sums = 0 
k=1
while k<= length(ops) && sums!=result
    sums = numbers[1]
    for j in 1:(length(numbers)-1)
        if ops[k][j] == "+"
           sums += numbers[j+1]
        else
            sums *= numbers[j+1]
        end
    end
    if sums == result
        push!(indicies,i)
    end
    k+=1
end
end
ans1 = 0
for n in eachindex(indicies)
dataline  = split(lines[indicies[n]]," ")
dataline[1]
result = parse(Int,chop(dataline[1],tail=1))
ans1+=result
end
println("part 1 answer = ",ans1)

#end of part 1 (1.38 seconds to run)

function concat(a,b)
    return parse(Int,string(a)*string(b))
end
 
indicies = Int[]
for i in eachindex(lines)
    dataline  = split(lines[i]," ")
    result = parse(Int,chop(dataline[1],tail=1))
    numbers = parse.(Int,dataline[2:length(dataline)])
    mat3 = collect(IterTools.product(fill(["+","*","|"], (length(numbers)-1))...))
    ops2 = reshape(mat3,(length(mat3),1))
    sums = 0 
    k=1
    while k<= length(ops2) && sums!=result
        sums = numbers[1]
        for j in 1:(length(numbers)-1)
            if ops2[k][j] == "+"
               sums += numbers[j+1]
            elseif ops2[k][j] == "*"
                sums *= numbers[j+1]
            elseif ops2[k][j] == "|"
                sums = concat(sums,numbers[j+1])
            end
        end
        if sums == result
            push!(indicies,i)
        end
        k+=1
    end
end

ans2 = 0
for n in eachindex(indicies)
dataline  = split(lines[indicies[n]]," ")
result = parse(Int,chop(dataline[1],tail=1))
ans2+=result
end
println("part 2 answer = ",ans2)

# part 2 (96.2 seconds to run)