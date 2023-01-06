// DEPENDENCE: test1.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import fs.*

let a = "abcdefghijklmn "
let b = "中国 "
let c = "1234"

main () {
    let path: String = "${getcwd()}/test1.txt"
    var file = File(path, Open(true, false))
    var reals = Okio.buffer(Okio.sink(file))
    let sou = Okio.source(file)
    try{     
    reals.write(sou,5)
    }catch(e: Exception){}
    reals.close()
    try{     
    reals.write(ByteString(Array<Byte>()))
    }catch(e: Exception){}
    try{     
    reals.write(Array<Byte>(5, item: 1))
    }catch(e: Exception){}
    try{     
    reals.write(Array<Byte>(5, item: 1),1,3)
    }catch(e: Exception){}

    try{     
    reals.flush()
    }catch(e: Exception){}

    try{     
    reals.emit()
    }catch(e: Exception){}

    try{     
    reals.close()
    }catch(e: Exception){}

    var es = ""
    try{     
    let str11 = reals.emitCompleteSegments()
    }catch(e: Exception){
        es = e.toString()
        println(es)
    }
     
    if(es != "IllegalArgumentException: closed.") {
        return 1
    }
    return 0
}
