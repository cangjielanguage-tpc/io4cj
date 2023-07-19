// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import fs.*

let a = "abcdefghijklmn "
let b = "中国 "
let c = "1234"

main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Open(true, false))
    var reals = Okio.buffer(Okio.sink(file))
    reals.write(Array<Byte>(5, item: 1))
    reals.write(Array<Byte>(5, item: 1),1,3)
    let sou = Okio.source(file)
    reals.write(sou,5)
    reals.timeout()
    reals.toString()
    var str = reals.isClosed()
    if(str) {
        return 1
    }
    return 0
}
