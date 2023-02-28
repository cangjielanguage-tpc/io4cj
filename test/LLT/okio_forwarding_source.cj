// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*

main () {

    let bu: Buffer = Buffer()
    let bu1: Buffer = Buffer()
    let s: String = "forwarding test"
    bu1.writeUtf8(s)
    let fwd: ForwardingSink = ForwardingSink(bu)
    let f1 = fwd.delegate()
    let f2 = fwd.write(bu1 , bu1.size)
    let f3 = fwd.flush()
    let f4 = fwd.timeout()
    let f5 = fwd.close()
    let f7 = fwd.toString()

    let bu2: Buffer = Buffer()
    let fws: ForwardingSource = ForwardingSource(bu)
    let s1 = fws.delegate()
    let s2 = fws.read(bu2 , bu.size)
    let s3 = fws.timeout()
    let s4 = fws.close()
    let s5 = fws.toString()
    try {
    let s6 = fws.isClosed()
    }catch(e: Exception){
        e.toString()
    }
    
    return 0
}
