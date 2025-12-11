
    f = "/home/er19801/julia_code/Advent-of-code-24/Datafiles/Day6Data.txt"
    lines = readlines(f)
    list = [if i<=length(line) line[i] else "" end for line in lines for i in length(lines):-1:1]
    rawdata = rotr90(reshape(list,length(lines),length(lines)))
    data = deepcopy(rawdata)
    
    window = 5
    T = 1/(1*11)
    draw = true
    p = 5 
    directions = [CartesianIndex(-1,0),CartesianIndex(0,1),CartesianIndex(1,0),CartesianIndex(0,-1)]
    facing = Dict(1=>'^',2=>'>',3=>'v',4=>'<')
    coord = findfirst(x->x=='^',data)
    state = 1
    
    while get(data, coord+directions[state], ' ') != ' '
        if  get(data, coord+directions[state], ' ') == '#'
            state = state%4+1
            data[coord] = 'X'
            data[coord+directions[state]] = facing[state]
            coord += directions[state]
        else
            data[coord] = 'X'
            data[coord+directions[state]] = facing[state]
            coord += directions[state]    
        end
        if draw == true
            println()
            a = coord - CartesianIndex(p,p)
            b = coord + CartesianIndex(p,p)
            image = get(data, (a[1]:b[1],a[2]:b[2]), 'E') 
            for i in eachindex(eachrow(image))
                println(eachrow(image)[i])
            end
            sleep(T)
        end
    end
    path = findall(x->x=='X'||x=='^'||x=='>'||x=='v'||x=='<',data)
    ans1 = length(path)
    println("part 1 answer = ",ans1)

##end of part 1 

directions = [CartesianIndex(-1,0),CartesianIndex(0,1),CartesianIndex(1,0),CartesianIndex(0,-1)]
facing = Dict(1=>'^',2=>'>',3=>'v',4=>'<')
    ans2 = 0 
    for i in eachindex(path)
        println(i)
        visited = Dict()
        data = deepcopy(rawdata)

        coord = findfirst(x->x=='^',data)

        data[path[i]] = 'O'

        state = 1 
        loops = false
        while loops == false && get(data, coord+directions[state], ' ') != ' '
            if !((coord,state) in keys(visited))
                visited[(coord,state)] = true
                if  get(data, coord+directions[state], ' ') == '#' || get(data, coord+directions[state], ' ') == 'O'
                    state = state%4+1
                    data[coord] = 'X'
                    data[coord+directions[state]] = facing[state]
                    coord += directions[state]
                else
                    data[coord] = 'X'
                    data[coord+directions[state]] = facing[state]
                    coord += directions[state]    
                end
            else 
                ans2 += 1
                loops = true
            end
        end
        println(length(visited))
        println(loops)
end
    println("part 2 answer = ", ans2)

#2162
