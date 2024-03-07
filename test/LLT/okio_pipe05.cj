// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {
    //sinkClose
    let pi: Pipe = Pipe(100)
    let bu: Buffer = Buffer()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toArray()
    pi.sink().close()
    try{
        pi.sink().write(bu.write(abc),3)
    }catch(e: IllegalStateException){
    }

    try{
        pi.sink().flush()
    }catch(es: IllegalStateException) {
    }
    //multipleClose
    let pi11: Pipe = Pipe(100)
    pi11.sink().close()    
    pi11.sink().close()
    let pi111: Pipe = Pipe(100)
    pi111.source().close()    
    pi111.source().close()    

    //sourceClose
     let pi22: Pipe = Pipe(100)
     let bu22: Buffer = Buffer()   
     pi22.source().close()
     try{
        pi.source().read(bu22,3)
    }catch(e: IllegalStateException){
    }

    //foldDoesNotFlushWhenThereIsNoFoldedData
    let pi33: Pipe = Pipe(100)
    let bu33: Buffer = Buffer()

    let bs: BufferedSink = Okio.buffer(bu33)
    bs.writeUtf8("hello")
    pi33.fold(bs)
    try{
        bu33.readUtf8()
    }catch(e: Exception){
    }


    return 0
}
