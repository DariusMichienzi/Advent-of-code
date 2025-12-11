f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day25Data.txt"
lines = readlines(f)
linesplit = findall(x->x=="",lines)
push!(linesplit,length(lines)+1)

key = []
locks = []
for i in eachindex(linesplit)
R = linesplit[i]-7:linesplit[i]-1
tmblr = reshape(reverse(vcat(reverse(collect.(lines[R]))...)),(5,7))
code = []
for i in 1:5
    push!(code,length(findall(x->x=='#',tmblr[i,:]))-1)
end
if tmblr[1,1] == '#'
    push!(locks,reverse(code))
else 
    push!(key,reverse(code))
end
end

ans1 = 0 
for i in locks
    for j in key
        if maximum(i .+ j) <= 5 
            ans1 += 1 
        end
    end
end
println("part 1 answer = ",ans1)

#part 1 only

