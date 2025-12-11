# did have some 'inspiration' for the solution here
f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day11Data.txt"
data = parse.(Int,split(readlines(f)[1]," "))::Vector{Int64}

function  stone_count(value, number, mem=Dict())
    if number == 0
        return 1
    end
    if !((value, number) in keys(mem))
            mem[(value, number)] = if value == 0
            stone_count(1, number - 1, mem)
        elseif iseven(ndigits(value))
            n = 10^(ndigits(value) >> 1)
            first = value ÷ n
            tail = value % n
            stone_count(first, number - 1, mem) + stone_count(tail, number - 1, mem)
        else
            stone_count(value*2024, number - 1, mem)
        end
    end
    return mem[(value, number)]
end

ans1 = sum(stone_count.(data,25))
println("part 1 answer = ",ans1)

#end of part 1
@time begin
ans2 = sum(stone_count.(data,75))
end
println("part 2 answer = ",ans2)
