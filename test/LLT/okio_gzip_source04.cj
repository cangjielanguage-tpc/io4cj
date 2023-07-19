// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from compress import zlib.*
from std import fs.*

main () {
    let infla: Buffer = Buffer()
    let arr: Array<UInt8> = [5, 64, 1, 10, 128, 48, 8, 252, 202, 61, 106, 31, 40, 59, 82, 34, 39, 42, 12, 246, 250, 49, 88, 141, 165, 108, 101, 226, 221, 22, 101, 254, 65, 46, 199, 77, 200, 252, 35, 89, 197, 231, 0]
    let bu: Buffer = Buffer()
    bu.write(arr)
    let sou: InflaterSource = InflaterSource(bu)
    var sou1 = sou.read(infla , 1)
    sou.close()
    var a: String = infla.readUtf8()

    if("T" != a.toString()) {
        return 1
    }
    return 0
}
