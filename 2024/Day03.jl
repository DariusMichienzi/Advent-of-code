f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day3Data.txt"
data = read(f, String)

matches = findall(r"mul\(\d+,\d+\)", data)
ans1 = 0
for i in eachindex(matches)
    numbers = parse.(Int,split(filter(x -> !(x in ['m','u','l','(',')']), data[matches[i]]),","))
    ans1 += numbers[1]*numbers[2]
end
println("part 1 answer = ",ans1)

# end of part 1

datamod = "do()"*data*"don't()"
regions = findall(r"(?s)do\(\)(.*?)don't\(\)", datamod)
ans2 = 0
for i in eachindex(regions)
    matches2 = findall(r"mul\(\d+,\d+\)", datamod[regions[i]])
    for j in eachindex(matches2)
        numbers2 = parse.(Int,split(filter(x -> !(x in ['m','u','l','(',')']), datamod[regions[i]][matches2[j]]),","))
        ans2 += numbers2[1] * numbers2[2]
    end
end

println("part 2 answer = ",ans2)