# | ⊻ & 
f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day24Data.txt"
lines = readlines(f)
linesplit = findfirst(x->x=="",lines)
initial = split.(lines[1:linesplit-1],": ")
instructions = split.((lines[linesplit+1:end])," ")

vals = Dict()
funcs = Dict("OR"=>|,"XOR"=>⊻,"AND"=>&)

for setting in initial
    vals[setting[1]] = parse(Int,setting[2])
end

tofind = length(findall(x->startswith(x,'z') ,vcat(instructions...)))
zees = 0
while zees != tofind 
    ops = popfirst!(instructions)
     if ops[1] in keys(vals) && ops[3] in keys(vals)
        vals[ops[5]] = funcs[ops[2]](vals[ops[1]],vals[ops[3]])
        if startswith(ops[5],'z')
            zees +=1
        end
     else 
        push!(instructions,ops)
     end
end

ans1 = 0 
for i in 1:tofind
ans1 += (2^(i-1))*vals[sort(collect(filter(x->startswith(x,'z'),keys(vals))))[i]]
end
println("part 1 answer = ",ans1)

#end of part 1 

xs = parse.(Int,hcat(initial[1:45]...)[2,:])
ys = parse.(Int,hcat(initial[46:90]...)[2,:])
x=0
y=0
for i in 1:45
    x += (2^(i-1))*xs[i]
    y += (2^(i-1))*ys[i]
end
z = x + y 

println("ans1 = ",chop(bitstring(ans1),head=64-45,tail=0))
println("z    = ",chop(bitstring(z),head=64-45,tail=0))

v= collect(chop(bitstring(xor(ans1,z)),head=64-45,tail=0))
for i in eachindex(v)
    if v[i] == '1'
        println("difference at bit ",45-i)
    end
end

#part 2 was done manualy from here using the information to help find errors without checking each manualy 
#took around 1hr 