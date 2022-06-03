module Smartphores


export Smartphore, acquire, release 

mutable struct Smartphore
    size        ::  Int
    counter     ::  Int
    cond_wait   ::  Threads.Condition
    taken       ::  Vector{ Bool }
    Smartphore(size) = size > 0 ? new(size, 0, Threads.Condition(), fill( false, size ) ) : throw(ArgumentError("Smartphore size must be > 0"))
end


function acquire( s :: Smartphore)
    myspot = 0
    lock(s.cond_wait)
    try
        while s.counter >= s.size
            wait(s.cond_wait)
        end

        for i ∈ 1 : s.size
            if !s.taken[i]
                s.taken[i] = true
                myspot = i
                break
            end
        end
        s.counter += 1
    finally
        unlock(s.cond_wait)
    end
    return myspot
end


function release( s :: Smartphore, myspot :: Int )
    lock(s.cond_wait)
    try
        s.counter > 0 || error("release count must match acquire count")
        if !s.taken[myspot] error( "trying to release a vacant spot") end
        s.taken[myspot] = false 
        s.counter -= 1
        notify(s.cond_wait; all=false)
    finally
        unlock(s.cond_wait)
    end
    return
end
    

end


