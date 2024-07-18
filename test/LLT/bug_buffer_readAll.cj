// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.fs.*

main () {
    let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
    let a_buffer = Buffer()
    a_buffer.write(arrb)

    let path: String = "./okio_readAll_057.txt"
    var file = File(path, CreateOrAppend)
    let sink: Sink = Okio.sink(file)
    if (a_buffer.size != 9) {
        return 1
    }
    if(a_buffer.readAll(sink) != 9) {
        return 1
    }
    if(a_buffer.size != 0) {
        return 1
    }

    var file1 = File(path, Open(true,false)) 
    if (file1.readToEnd().size != 9) {
        return 1
    }
    return 0
}