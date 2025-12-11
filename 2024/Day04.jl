f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day4Data.txt"
lines = readlines(f)
list = [if i<=length(line) line[i] else "" end for line in lines for i in 1:length(lines)]
data = reshape(list,length(lines),length(lines))

XMAS = ['X','M','A','S']

diagK = 
[[1;;0;;0;;0];
[0;;1;;0;;0];
[0;;0;;1;;0];
[0;;0;;0;;1]]

diagC = 
[["X";;"";;"";;""];
["";;"M";;"";;""];
["";;"";;"A";;""];
["";;"";;"";;"S"]]

total = Int[]
for i in eachindex(data[1,:])
    for j in 1:length(data[:,1])-3
    if data[i,j:(j+3)] == XMAS
        push!(total,1)
    elseif data[i,j:(j+3)] == reverse(XMAS)
        push!(total,1)
    end
end
end

for i in eachindex(data[1,:])
    for j in 1:length(data[:,1])-3
    if data[j:(j+3),i] == XMAS
        push!(total,1)
    elseif data[j:(j+3),i] == reverse(XMAS)
        push!(total,1)
    end
end
end

for i in 1:length(data[1,:])-3
    for j in 1:length(data[:,1])-3
        for k in 1:4
            if data[j:(j+3),i:(i+3)] .^ rotr90(diagK,k) == rotr90(diagC,k)
            push!(total,1)
            end
        end
    end
end

ans1 = sum(total)
println("part 1 answer = ",ans1)

#end of part 1

X =
[[1;;0;;1];
[0;;1;;0];
[1;;0;;1];]

mas=
[["M";;"";;"S"];
["";;"A";;""];
["M";;"";;"S"];]

total2 = []
for i in 1:(length(data[1,:])-2)
    for j in 1:(length(data[:,1])-2)
        for k in 1:4
            if data[j:(j+2),i:(i+2)] .^ X == rotr90(mas,k)
                push!(total2,1)
            end
        end
    end
end

ans2 = sum(total2)
println("part 2 answer = ",ans2)