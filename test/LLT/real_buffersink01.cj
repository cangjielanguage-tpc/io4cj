// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

let a = "abcdefghijklmn "
let b = "中国 "
let c = "1234"

main () {
    let path: String = "${getcwd()}/test.txt"

    var file = File(path, Read, Open)

    var reals = Okio.buffer(Okio.sink(file))
    reals.write(ByteString(Array<Byte>()))
    reals.write(Buffer(),0)
    reals.writeAll(Buffer())
    reals.writeUtf8("dsa",0 ,1)
    reals.writeUtf8CodePoint(1)
    reals.writeInt8(1)
    reals.writeInt16(1)
    reals.writeInt64(1)
    reals.writeInt16Le(1)
    reals.writeInt32(1)
    reals.writeInt32Le(1)
    reals.writeInt64Le(1)
    reals.writeDecimalInt64(1)
    reals.writeHexadecimalUInt64(1)
    var str = reals.isClosed()
    if(str) {
        return 1
    }
    return 0
}
