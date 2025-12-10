using Combinatorics
f = "./DataFiles/Day10.txt"
lines = readlines(f)
lights = []
buttons = []
batteries = []

for line in lines
#line = lines[1]
splitline = split(line," ")
light = [c == '#' ? 1 : 0 for c in splitline[1] if c in ('.', '#')]
button = [(parse.(Int, split(strip(s, ['(', ')']), ",")) .+ 1) for s in splitline[2:end-1]]
battery = parse.(Int, split(strip(splitline[end] , ['{', '}']), ","))
push!(lights,light)
push!(buttons,button)
push!(batteries,battery)
end
ans1 = 0 
for i in eachindex(lights)
    light = copy(lights[i])
    button = buttons[i]
    solved = false
    j = 1
    while solved == false
        combs = collect(with_replacement_combinations(button,j)) 
        for k in combs
            for b in k
                light[b] .= light[b] .⊻ 1
            end
            if !(1 in light)
                solved = true
                ans1 += j
                break
            else
                light =  copy(lights[i])
            end
        end
        j += 1
    end
end
println("Part 1 answer = $ans1")
#end of part 1
using JuMP, HiGHS

ans2 = 0
for i in eachindex(batteries)
    button = buttons[i]
    battery = batteries[i]
    mat = zeros(Int,length(battery),length(button))
    for j in eachindex(button)
        for k in button[j]
            mat[k,j] = 1
        end
    end
    
    m, n = size(mat)  
    model = Model(HiGHS.Optimizer)
    set_silent(model)
    @variable(model, x[1:n] >= 0, Int)
    @constraint(model, mat * x .== battery)
    @objective(model, Min, sum(x))
    
    optimize!(model)
    
    ans2 += sum(Int.(round.((value.(x)))))
end
println("Part 2 answer = $ans2")