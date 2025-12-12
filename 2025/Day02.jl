f = "./DataFiles/Day02.txt"
lines = split.(split(readline(f),","),"-")

ans1 = 0 
for line in lines
L = parse.(Int,line)
    R = collect(range(L[1],L[2]))
    for k in R
        N = ndigits(k)
        if N % 2 == 0 && k ÷ 10 ^ (ndigits(k)-N÷2) == k % 10 ^ (ndigits(k)-N÷2)
            global ans1 += k
        end
    end
end
println("Part 1 answer = $ans1")

#end of part 1 

function concat(N,r)
    parse(Int,(string(N)^r))
end

ans2 = 0 
for line in lines
    L = parse.(Int,line)
    R = collect(range(L[1],L[2]))
    for k in R
        N = ndigits(k)
        for i in 1:(ndigits(k)÷2)
            T = k ÷ 10 ^ (ndigits(k)-i)
            if concat(T,N ÷ i) == k
                global ans2 += k
                break
            end
        end
    end
end
println("Part 2 answer = $ans2")