f = "./DataFiles/Day11.txt"
lines = split.(readlines(f),": ")

cons = Dict()
for line in lines
    cons[line[1]] = vec(split(line[2], " "))
end

function pathcount(current, final, cons, mem = Dict())
    if current == final
        return 1
    end

    if !((current,final) in keys(mem))
        S = 0  
        if final == "out"
            S = sum([pathcount(A,final,cons,mem) for A in cons[current]])
        else
            for A in cons[current]
                if !(A=="out")
                    S += pathcount(A,final,cons,mem)
                end
            end
        end
        mem[(current,final)] = S
    end
    return mem[(current, final)]
end

ans1 = pathcount("you","out",cons)

ans2 = pathcount("svr","fft",cons)*pathcount("fft","dac",cons)*pathcount("dac","out",cons) + pathcount("svr","dac",cons)*pathcount("dac","fft",cons)*pathcount("fft","out",cons)

println("Part 1 answer = $ans1")
println("Part 2 answer = $ans2")