f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day21Test.txt"
lines = readlines(f)
data = split.(lines,"")

numberspad = ['7' '8' '9'; '4' '5' '6'; '1' '2' '3'; ' ' '0' 'A']
directionspad = [' ' '^' 'A'; '<' 'v' '>']
directions = [['^',CartesianIndex(-1,0)],['>',CartesianIndex(0,1)],['v',CartesianIndex(1,0)],['<',CartesianIndex(0,-1)],]

function propcode(grid,code,start = findfirst(x->x=='A', grid),path = [])
    if code == []
        return [copy(path)]
    end
    finish = findfirst(x->x==(code[1]), grid)
    if start == finish
        push!(path, 'A')
        result = propcode(grid, code[2:end], start, path)
        pop!(path)
        return result
    end
    result = []
    for (symbol,direct) in directions
        if get(grid, start + direct, ' ') == ' '
            continue
        end
        if abs(finish[1] - start[1] - direct[1])+ abs(finish[2] - start[2] - direct[2]) > abs(finish[1] - start[1])+ abs(finish[2] - start[2])
            continue
        end
        push!(path, symbol)
        append!(result, propcode(grid, code, start + direct, path))
        pop!(path)
    end
    return result
end
propcode(numberspad,only.(data[1]))


function countcode(iters, code, mem = Dict())
    if iters == 0
        return length(code)
    end
    if (iters, code) in keys(mem)
        return mem[iters, code]
    end
    lengthtot = 0
    start = findfirst(x->x=='A', directionspad)
    for key in code
        minlength = Inf
        for path in propcode(directionspad, [key], start)
            l = countcode(iters - 1, path, mem)
            if l < minlength
                minlength = l
            end
        end
        start = findfirst(x->x==(key), directionspad)
        lengthtot += minlength
    end
    mem[level, code] = lengthtot
    return lengthtot
end


function compute(codes)
    part1 = 0
    part2 = 0
    for code in codes
        prevpaths = propcode(numberspad, code)
        minlen1 = minimum(countcode(2, path) for path in prevpaths)
        minlen2 = minimum(countcode(25, path) for path in prevpaths)
        num = reduce(filter(isdigit, code), init = 0) do a, b
            a * 10 + (b - '0')
        end
        part1 += num * minlen1
        part2 += num * minlen2
    end
    println(part1)
    println(part2)
end
compute(only.(data[1]))