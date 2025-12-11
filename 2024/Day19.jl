f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day19Data.txt"
lines = readlines(f)
linesplit = findfirst(x->x=="",lines)
towels = split(lines[1:linesplit-1][1],", ")
patterns = (lines[linesplit+1:end])

function countpossible(towels,pattern,mem=Dict())
    if pattern == ""
        return 1
    end
    if pattern in keys(mem)
        return mem[pattern]
    end
    mem[pattern] = 0
    for towel in towels
        if !(startswith(pattern, towel))
            continue
        end
        mem[pattern] += countpossible(towels, pattern[length(towel)+1:end],mem)
    end
    return mem[pattern]
end

ans1 = 0
ans2 = 0
for pattern in patterns
    ans1 += 1 - 0^countpossible(towels,pattern)
    ans2 += countpossible(towels,pattern)
end
println("part 1 answer = ",ans1)
#end of part 1 
println("part 2 answer = ",ans2)