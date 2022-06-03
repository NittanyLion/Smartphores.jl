push!( LOAD_PATH, "." )

using Smartphores

function howthisworks( n )
    blocks = [ zeros(5) for i ∈ 1:n ]
    
    s = Smartphore( n )
    Threads.@threads for i ∈ 1 : 20
        local a = acquire!( s )
        println( "thread $(Threads.threadid()) says: block $a is mine, all mine" )
        blocks[a] .= i
        sleep(1)
        println( "thread $(Threads.threadid()) says: I'm giving block $a back" )
        release!( s, a )
    end
end

howthisworks( 3 )
