f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day9Data.txt"
data = read(f, String)
j=0
output = ""

for i in eachindex(data)
    if i%2 == 1
    output *= ("_"*string(j))^parse(Int,data[i])
    j += 1 
    else
    output *= "."^parse(Int,data[i])
    end
end

output
function change_character(S, n, k)
    return SubString(S, 1, n-1) * k * SubString(S, n+1, length(S))
end

totalmt = length(findall(x->x=='.',output))
while length(findall(x->x=='.',output)) != 0
if output[length(output)] == '.'
output = chop(output,tail=1)
else
firstindex = findfirst(x->x=='.',output)
lastdigindex = findfirst(r"\d+",output[findlast(x->x=='_',output):length(output)])
lastnumer = output[findlast(x->x=='_',output):length(output)][lastdigindex]
output = change_character(output,firstindex,'_'*lastnumer)
output = chop(output, tail=length(lastnumer)+1)
end
end

outlist = split(output,"_")
popfirst!(outlist)

ans1 = 0
for i in eachindex(outlist)
ans1 += parse(Int,outlist[i])*(i-1)
end

println("part 1 answer = ",ans1)

# end of part 1

data = parse.(Int, split(readline(f), ""))
file_length = data[1:2:end]
space_length = data[2:2:end]
file_id = collect(0:length(file_length)-1)
moved = falses(length(file_id))
ans2 = 0
position = 0
    
i = 1
while i <= length(file_length)
while file_length[i] > 0
    if moved[i] == 1
    position += file_length[i]
    break
    end
ans2 += file_id[i] * position
position += 1
file_length[i] -= 1
end
while i <= length(space_length) && space_length[i] > 0
    j = length(file_id)
    while j > i && (moved[j] || file_length[j] > space_length[i])
    j -= 1
    end
    if j == i
    position += space_length[i]
    break
    end
    moved[j] = true
    for _ in 1:file_length[j]
    ans2 += file_id[j] * position
    position += 1
    space_length[i] -= 1
    end
    end
    i += 1
end

println("part2 answer = ", ans2)