# Smartphores.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://NittanyLion.github.io/Smartphores.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://NittanyLion.github.io/Smartphores.jl/dev/)
[![Build Status](https://github.com/NittanyLion/Smartphores.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/NittanyLion/Smartphores.jl/actions/workflows/CI.yml?query=branch%3Amain)

*Smartphores.jl* provides the standard semaphores machinery with the sole distinction that smartphores provide ids to available slots.  This can be helpful if one has allocated $n$ chunks of memory that are to be shared, so a call to `acquire` then return an integer value that indicates which chunk is assigned.

There are only three calls:

`Smartphore( size :: Int )` creates 

`acquire( s :: Smartphore )` acquires a permit and returns its id

`release( s :: Smartphore, permitid :: Int )` releases the permit


