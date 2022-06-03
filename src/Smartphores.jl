module Smartphores


export Smartphore, acquire, release 

"""
    Smartphore( size )

Create a counting semaphore that allows at most `size`
acquires to be in use at any time.  The only difference with the
Base Semaphore call is that Smartphores tell you which permit id you received, which can e.g. be helpful if there are `size` bits of prereserved memory to be shared.

Each acquire must be matched with a release.
This provides a acquire & release memory ordering on acquire/release calls.
"""
mutable struct Smartphore
    size        ::  Int
    counter     ::  Int
    cond_wait   ::  Threads.Condition
    taken       ::  Vector{ Bool }
    Smartphore(size) = size > 0 ? new(size, 0, Threads.Condition(), fill( false, size ) ) : throw(ArgumentError("Smartphore size must be > 0"))
end

"""
    acquire( s :: Smartphore )

Wait for one of the `size` permits to be available,
blocking until one can be acquired and then returns the id of the requested permit.
"""
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


"""
    release(s :: Smartphore, myspot :: Int )

Return permit myspot to the pool,
possibly allowing another task to acquire it
and resume execution.
"""
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


