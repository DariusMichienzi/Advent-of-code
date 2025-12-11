f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day22Data.txt"
lines = readlines(f)
data = parse.(Int,lines)

function secretnumber(num,iterations)
prices = [num]
for i in 1:iterations
step1 = mod(xor(num*64 , num),16777216)
step2 = mod(xor(step1÷32 , step1),16777216)
step3 = mod(xor(step2*2048 , step2),16777216)
num = step3 
push!(prices,num)
end
return prices
end

ans1 = 0 
for num in data
    ans1+=secretnumber(num,2000)[2001]
end
println("part 1 answer = ",ans1)

# end of part 1 

mem = Dict()
for d in data
    datatested = Dict()
    prices = secretnumber(d,2000) .% 10
    pricechange = [prices[i] - prices[i-1] for i in 2:length(prices)]
    for i in 1:length(pricechange)-3
        if !(pricechange[i:i+3] in keys(mem))
            mem[pricechange[i:i+3]] = prices[i+4]
            datatested[pricechange[i:i+3]] = true
        elseif pricechange[i:i+3] in keys(mem) && !(pricechange[i:i+3] in keys(datatested))
            mem[pricechange[i:i+3]] += prices[i+4]
            datatested[pricechange[i:i+3]] = true
        end
    end
end

ans2 = maximum(values(mem))
println("part 2 answer = ",ans2)