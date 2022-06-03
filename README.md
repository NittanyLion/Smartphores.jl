# Smartphores.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://NittanyLion.github.io/Smartphores.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://NittanyLion.github.io/Smartphores.jl/dev/)
[![Build Status](https://github.com/NittanyLion/Smartphores.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/NittanyLion/Smartphores.jl/actions/workflows/CI.yml?query=branch%3Amain)

*Smartphores.jl* provides the standard semaphores machinery with the sole distinction that smartphores provide ids to available slots.  This can be helpful if one has allocated $n$ chunks of memory that are to be shared, so a call to `acquire!` then returns an integer value that indicates which chunk is assigned, which should be released using `release!`.

There are only three calls:

`Smartphore( size :: Int )` creates 

`acquire!( s :: Smartphore )` acquires a permit and returns its id

`release!( s :: Smartphore, permitid :: Int )` releases the permit

All of this is a mild hack of the standard Julia Semaphore machinery found in `lock.jl`.  The same MIT license applies.

Here is a simple example to demonstrate:
````
using Smartphores

function howthisworks( n )
    blocks = [ zeros(5) for i ∈ 1:n ]
    
    s = Smartphore( n )
    Threads.@threads for i ∈ 1 : 20
        local a = acquire!( s )
        println( "thread $(Threads.threadid()) says: block $a is mine, all mine" )
        blocks[a] .= i
        sleep(1)
        println( "thread $(Threads.threadid()) says: block I'm giving block $a back" )
        release!( s, a )
    end
end

howthisworks( 3 )
````
