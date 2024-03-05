// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {
    let pi: Pipe = Pipe(6)
    let bu: Buffer = Buffer()
    //let bs: BufferedSink = RealBufferedSink()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toArray()
    pi.sink().write(bu.write(abc) , 3)

    let so: Source = pi.source()
    let bu1: Buffer = Buffer()


    if(so.read(bu1,6) != 3) {
        return 1
    }
    if(bu1.readUtf8() != "abc") {
        return 1
    }
    pi.sink().close()

    if(so.read(bu1 , 6) != -1){
        return 1
    }
    so.close()
    return 0
}