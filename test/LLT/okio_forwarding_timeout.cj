// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*

main () {

    let str = Timeout()
    let str1 = str.timeout(1)
    let str2 = str.deadlineNanoTime(1)


    let ft: ForwardingTimeout = ForwardingTimeout(str)
    let ft2 = ft.setDelegate(str)
    let ft1 = ft.delegate()
    let ft4 = ft.timeout(1)
    let ft5 = ft.timeoutNanos()
    let ft6 = ft.hasDeadline()
    let ft7 = ft.deadlineNanoTime()
    let ft8 = ft.deadlineNanoTime(1)
    let ft9 = ft.clearTimeout()
    let ft10 = ft.clearDeadline()
    let ft11 = ft.throwIfReached()
    var es: String = ""
    try {
        //let str01 = str.timeout(0)
        let ft04 = ft.timeout(-1)
    }catch(e: Exception) {
        es = e.toString()
    }

    var es2: String = ""
    try {
        let ft004 = ft.timeout(0)
        let ft02 = ft.setDelegate(str)
    }catch(e: Exception) {
        es2 = e.toString()
        println(es2)
    }
    if(es != "IllegalArgumentException: timeout < 0: -1"){
        return 1
    }   
    return 0


}
