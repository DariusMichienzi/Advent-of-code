f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day17Data.txt"
lines = readlines(f)
linesplit = findfirst(x->x=="",lines)

literal = [0,1,2,3]
regs = append!(literal,parse.(Int,hcat(split.(lines[1:linesplit-1]," ")...)[3,:]))
program = parse.(Int,split(split.(prod(lines[linesplit+1:end])," ")[2],","))

function outputcode(program,regs)
    output = []
    point = 0
while point<length(program)
    opcode = program[point+1]
    operand = program[point+2]
    combo = regs[operand+1]
if opcode == 0 
    regs[5] = regs[5] >> combo
elseif opcode == 1
    regs[6] = xor(regs[6],operand)
elseif opcode == 2
    regs[6] = mod(combo,8)
elseif opcode == 3 && regs[5] !=0
    point = operand
    continue
elseif opcode == 4
    regs[6] = xor(regs[6],regs[7])
elseif opcode == 5
    push!(output,mod(combo,8))
elseif opcode == 6
    regs[6] = regs[5] >> combo
elseif opcode == 7
    regs[7] = regs[5] >> combo
end
point+=2
end
return output
end

out = outputcode(program,regs)
answer=""
for i in out
    answer *= string(i)*","
end
ans1 = chop(answer,tail=1)
println("part 1 answer = $ans1")

#end of part 1 

answers = []
test=[(1,0)]
for (i,a) in test
    for k in a:a+8
        if i<17 && outputcode(program,[0,1,2,3,k,0,0]) == reverse(reverse(program)[1:i])
            push!(test,(i+1, k*8))
            if i == length(program)
                push!(answers,k)
            end
        end
    end
end

ans2 = minimum(answers)
println("part 2 answer = ",ans2)
