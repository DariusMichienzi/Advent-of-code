f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day15Data.txt"
lines = readlines(f)
linesplit = findfirst(x->x=="",lines)
rawdata = lines[1:linesplit-1]
inst = prod(lines[linesplit+1:end])

list = [if i<=length(line) line[i] else "" end for line in rawdata for i in length(rawdata):-1:1]
data = rotr90(reshape(list,length(rawdata),length(rawdata)))
directions = [CartesianIndex(0,1),CartesianIndex(1,0),CartesianIndex(0,-1),CartesianIndex(-1,0)]

for i in inst
coord = findfirst(x->x=='@',data)
    if i == '>'    
    lookright = data[coord[1],coord[2]:end]
        if get(data, coord+directions[1], ' ') == '.'
            data[coord+directions[1]] = '@'
            data[coord] = '.'
        elseif get(data, coord+directions[1], ' ') == 'O'
            wall = findfirst(x->x=='#',lookright)
            space = findfirst(x->x=='.',lookright)
            if space !== nothing && space < wall
                data[coord+directions[1]] = '@'
                data[coord[1],coord[2]+space-1] = 'O'
                data[coord] = '.'
            end
        end
    elseif i == 'v'    
    lookdown = data[coord[1]:end,coord[2]]
        if get(data, coord+directions[2], ' ') == '.'
            data[coord+directions[2]] = '@'
            data[coord] = '.'
        elseif get(data, coord+directions[2], ' ') == 'O'
            wall = findfirst(x->x=='#',lookdown)
            space = findfirst(x->x=='.',lookdown)
            if space !== nothing && space < wall
                data[coord+directions[2]] = '@'
                data[coord[1]+space-1,coord[2]] = 'O'
                data[coord] = '.'
            end
        end
    elseif i == '<'    
    lookleft = reverse(data[coord[1],1:coord[2]])
        if get(data, coord+directions[3], ' ') == '.'
            data[coord+directions[3]] = '@'
            data[coord] = '.'
        elseif get(data, coord+directions[3], ' ') == 'O'
            wall = findfirst(x->x=='#',lookleft)
            space = findfirst(x->x=='.',lookleft)
            if space !== nothing && space < wall
                data[coord+directions[3]] = '@'
                data[coord[1],coord[2]-space+1] = 'O'
                data[coord] = '.'
            end
        end
    elseif i == '^'    
        lookup = reverse(data[1:coord[1],coord[2]])
        if get(data, coord+directions[4], ' ') == '.'
            data[coord+directions[4]] = '@'
            data[coord] = '.'
        elseif get(data, coord+directions[4], ' ') == 'O'
            wall = findfirst(x->x=='#',lookup)
            space = findfirst(x->x=='.',lookup)
            if space !== nothing && space < wall
                data[coord+directions[4]] = '@'
                data[coord[1]-space+1,coord[2]] = 'O'
                data[coord] = '.'
            end
        end
    end
end
final = findall(x->x=='O',data)
x = getindex.(final, 1)
y = getindex.(final, 2)  
ans1 = sum(100(x.-1))+sum(y.-1)
println("part 1 answer = ",ans1)

# end of part 1 
# had to look to get some help for part 2 

dir = Dict('<'=>CartesianIndex(0,-1),'>'=>CartesianIndex(0,1),'^'=>CartesianIndex(-1,0),'v'=>CartesianIndex(1,0))
datastring = prod(rawdata)
rawstring = ""
for j in datastring
    if j == '#'
        rawstring *= "##"
    elseif j == 'O'
        rawstring *= "[]"
    elseif j == '.'
        rawstring *= ".."
    elseif j == '@'
        rawstring *= "@."
    end
end
data2 = permutedims(reshape(collect(rawstring),(2*size(data)[1],size(data)[1])))

function move(coord, dir, data)
    new = coord + dir
    if data[new] == '#'
        return false
    elseif data[new] == '['
        if  !move(new+CartesianIndex(0,1),dir,data) || !move(new,dir,data)
            return false
        end
    elseif data[new] == ']'
        if !move(new+CartesianIndex(0,-1),dir,data) || !move(new,dir,data)
            return false
        end
    end
    data[new] = data[coord]
    data[coord] = '.'
    return true
end

coord = findfirst(data2 .== '@')
for i in inst
    saved = deepcopy(data2)
    if move(coord,dir[i],data2)
        coord += CartesianIndex(dir[i])
    else
        global data2 = saved
    end
end
data2
final = findall(data2.=='[')
ans2 = 0
for x in final
    ans2 += 100(x[1]-1)+(x[2]-1)
end
println("part 2 answer = ",ans2)