var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = Smartphores","category":"page"},{"location":"#Smartphores","page":"Home","title":"Smartphores","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Smartphores.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Smartphores]","category":"page"},{"location":"#Smartphores.Smartphore","page":"Home","title":"Smartphores.Smartphore","text":"Smartphore( size )\n\nCreate a counting semaphore that allows at most size acquires to be in use at any time.  The only difference with the Base Semaphore call is that Smartphores tell you which permit id you received, which can e.g. be helpful if there are size bits of prereserved memory to be shared.\n\nEach acquire must be matched with a release. This provides a acquire & release memory ordering on acquire/release calls.\n\n\n\n\n\n","category":"type"},{"location":"#Smartphores.acquire-Tuple{Smartphore}","page":"Home","title":"Smartphores.acquire","text":"acquire( s :: Smartphore )\n\nWait for one of the size permits to be available, blocking until one can be acquired and then returns the id of the requested permit.\n\n\n\n\n\n","category":"method"},{"location":"#Smartphores.release-Tuple{Smartphore, Int64}","page":"Home","title":"Smartphores.release","text":"release(s :: Smartphore, me :: Bool)\n\nReturn permit me to the pool, possibly allowing another task to acquire it and resume execution.\n\n\n\n\n\n","category":"method"}]
}