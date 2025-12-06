f = "./DataFiles/Day06.txt"
lines = readlines(f)

data = []
for line in lines
    push!(data,vec(filter(x->x!="",split(line," "))))
end
dataM = mapreduce(permutedims,vcat,data)
ans1 = 0
for prob in eachcol(dataM)
    nums = parse.(Int,prob[1:end-1])
    if prob[end] == "*"
        ans1 += prod(nums)
    elseif prob[end] == "+"
        ans1 += sum(nums)
    end
end
println("Part 1 answer = $ans1")
#end of part 1 
probsheet = mapreduce(permutedims,vcat,split.(lines,""))
blank = [" "," "," "," "," "]
ans2 = 0
i=1
while !(i == length(probsheet[1,:]))
    if probsheet[:,i] == blank
        prob = probsheet[:,1:i-1]
        probsheet = probsheet[:,i+1:end]
        i = 1
        if prob[end,1] == "+"
            ans = 0
            for col in eachcol(prob[1:end-1,:])
                ans += parse(Int,prod(col))
            end
        elseif prob[end,1] == "*"
            ans = 1
            for col in eachcol(prob[1:end-1,:])
                ans *= parse(Int,prod(col))
            end
        end
        ans2 += ans
    else
        i += 1
    end
end
prob = probsheet
if prob[end,1] == "+"
    ans = 0
    for col in eachcol(prob[1:end-1,:])
        ans += parse(Int,prod(col))
    end
elseif prob[end,1] == "*"
    ans = 1
    for col in eachcol(prob[1:end-1,:])
        ans *= parse(Int,prod(col))
    end
end
ans2 += ans
println("Part 2 answer = $ans2")