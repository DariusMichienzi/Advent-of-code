f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day13Data.txt"
lines = readlines(f)
Alines = lines[1:4:end]
Blines = lines[2:4:end]
prizelines = lines[3:4:end]
ans1 = 0 
for i in eachindex(Alines)
Ax = parse(Int,chop(split.(Alines," ")[i][3],head=2,tail=1))
Ay = parse(Int,chop(split.(Alines," ")[i][4],head=2,tail=0))
Bx = parse(Int,chop(split.(Blines," ")[i][3],head=2,tail=1))
By = parse(Int,chop(split.(Blines," ")[i][4],head=2,tail=0))
prizex = parse(Int,chop(split.(prizelines," ")[i][2],head=2,tail=1))
prizey = parse(Int,chop(split.(prizelines," ")[i][3],head=2,tail=0))

M = [Ax Bx; Ay By]
P = [prizex ; prizey]
A = M \ P
diffA = abs(A[1] - Int(round(A[1]))) 
diffB = abs(A[2] - Int(round(A[2])))

if diffA <10^-3 && diffB <10^-3 && 0 < A[1] < 100 && 0 < A[2] < 100 
ans1 += 3*Int(round(A[1]))
ans1 += Int(round(A[2]))
end
end

println("part 1 answer = ",ans1)

# end of part 1

ans2 = 0 
for i in eachindex(Alines)
Ax = parse(Int,chop(split.(Alines," ")[i][3],head=2,tail=1))
Ay = parse(Int,chop(split.(Alines," ")[i][4],head=2,tail=0))
Bx = parse(Int,chop(split.(Blines," ")[i][3],head=2,tail=1))
By = parse(Int,chop(split.(Blines," ")[i][4],head=2,tail=0))
prizex = parse(Int,chop(split.(prizelines," ")[i][2],head=2,tail=1))+10000000000000
prizey = parse(Int,chop(split.(prizelines," ")[i][3],head=2,tail=0))+10000000000000

M = [Ax Bx; Ay By]
P = [prizex ; prizey]
A = M \ P
diffA = abs(A[1] - Int(round(A[1]))) 
diffB = abs(A[2] - Int(round(A[2])))

if diffA <10^-3 && diffB <10^-3 && 0 < A[1] && 0 < A[2]  
ans2 += 3*Int(round(A[1]))
ans2 += Int(round(A[2]))
end
end

println("part 2 answer = ",ans2)