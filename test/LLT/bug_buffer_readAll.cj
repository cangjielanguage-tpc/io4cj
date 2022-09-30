// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
    let a_buffer = okio.Buffer()
    a_buffer.write(arrb)

    let path: String = "./okio_readAll_057.txt"
    var file = File(path, ReadWrite, OpenOrCreate)
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

    var file1 = File(path, Read, Open) 
    if (file1.readToEnd().size != 9) {
        return 1
    }
    return 0
}