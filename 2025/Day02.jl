#= f = "./Day02.txt"
lines = readlines(f) =#
@time begin
f = "./Day02.txt"
data = parse.(Int,split(readlines(f)[1]," "))::Vector{Int64}

function  stone_count(value, number, mem=Dict())
    if number == 0
        return 1
    end
    if !((value, number) in keys(mem))
        if value == 0
            mem[(value, number)] = stone_count(1, number - 1, mem)
        elseif iseven(ndigits(value))
            left = value ÷ 10^(ndigits(value) ÷ 2)
            right = value % 10^(ndigits(value) ÷ 2)
            mem[(value, number)] = stone_count(left, number - 1, mem) + stone_count(right, number - 1, mem)
        else
            mem[(value, number)] = stone_count(value*2024, number - 1, mem)
        end
    end
    return mem[(value, number)]
end

ans1 = sum(stone_count.(data,25))
println("part 1 answer = ",ans1)

#end of part 1

ans2 = sum(stone_count.(data,75))
println("part 2 answer = ",ans2)
end
