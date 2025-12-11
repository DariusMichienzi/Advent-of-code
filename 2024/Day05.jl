orderfile = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day5Orders.txt"
datafile = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day5Data.txt"
list = [parse(Int, split(line, "|")[i]) for line in readlines(orderfile), i in 1:2]
data = readlines(datafile)


function lookuplessthan(a,b)
    index = findall(x -> x == a, list[:,1])
    if b in list[index,2]
        return true
    else 
        return false
    end
end

ans1 = 0
ans2 = 0 
for i in eachindex(data)
    dataline  = parse.(Int,split(data[i],","))
    ordereddata = sort!(parse.(Int,split(data[i],",")),lt=lookuplessthan)
    if ordereddata == dataline
        ans1 += dataline[Int((length(dataline)+1)/2)]
    else
        ans2 += ordereddata[Int((length(ordereddata)+1)/2)]
    end
end
println("part 1 answer = ",ans1)

#end of part 1 

println("part 2 answer = ",ans2)