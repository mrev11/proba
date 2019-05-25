

static mutex:=thread_mutex_init()
static cond:=thread_cond_init()


*************************************************************************************************
function main()

local key

    ? "Press a key"

    thread_mutex_lock(mutex)

    thread_create({||sleep(5000),signal()})
    thread_create({||key:=inkey(0),signal()})

    thread_cond_wait(cond,mutex)    
    thread_mutex_unlock(mutex)

    if(key==NIL)
        ? "Timeout"
    else
        ? "Pressed", key
    end
    ?    


*************************************************************************************************
static function signal()
    thread_mutex_lock(mutex)
    thread_cond_signal(cond)
    thread_mutex_unlock(mutex)


*************************************************************************************************
