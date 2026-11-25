fish = parse.(Int,split(readline("2021_day6_data.txt"),","))

#= function CountFish(data,time)
    fish = copy(data) 
    day = 0
    while day < time
        for i in eachindex(fish)
            if fish[i] == 0 
                fish[i] = 6
                push!(fish,8)
            else
                fish[i] -= 1
            end
        end
        day += 1 
        println("Day $day: $(length(fish)) total fish")
    end
    return length(fish)
end
=#

function CountFish(data,N_Days)
    bins = zeros(Int,9)
    for i in eachindex(bins)
        bins[i]=count(x->x==i-1,data)
    end
    #println("Day 0: $(sum(bins)) total fish")
    for i in 1:N_Days
        rep = popfirst!(bins)
        push!(bins,rep)
        bins[7] += rep
        #println("Day $i: $(sum(bins)) total fish")
    end
    return sum(bins)
end

println("Answer part 1: $(CountFish(fish,80))")
println("Answer part 2: $(CountFish(fish,256))")
