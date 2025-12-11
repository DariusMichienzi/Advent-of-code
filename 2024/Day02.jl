f = readlines("/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day2Data.txt")

function conv(S)
    fsplit = split(S," ")
    A = []
    for i in eachindex(fsplit)
        push!(A,parse(Int,fsplit[i]))
    end
    return A
end

function monotonic(A)
    asc = sort(A)
    desc = sort(A,rev=true)
    if A == asc 
        return true
    elseif A == desc
        return true
    else 
        return false 
    end
end

function variance(A)
    l = length(A)
    T = []
for i in 1:(l-1)
    if abs(A[i] - A[i+1]) > 3
        push!(T,1)
    elseif abs(A[i] - A[i+1]) == 0
        push!(T,1)
    else
        push!(T,0)
    end
end
    if sum(T) > 0
        return false
    else
        return true
    end
end

P = []
for k in eachindex(f)
    a = conv(f[k])
    if monotonic(a) == true && variance(a) == true
        push!(P,1)
    end
end
ans1 = sum(P)
println("part 1 answer = ",ans1)

#end of part 1

P = []
for k in eachindex(f)
    a = conv(f[k])
    if monotonic(a) == true && variance(a) == true
        push!(P,1)
    else
        U = []
        for m in eachindex(a)
            k = deleteat!(deepcopy(a) ,m)
            if monotonic(k) == true && variance(k) == true
                push!(U,1)
            else
                push!(U,0)
            end
        end
            if sum(U) > 0
                push!(P,1)
            else
                push!(P,0)
            end
    end
end

ans2 = sum(P)
println("part 2 answer = ",ans2)