// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*

main () {
    let str = Array<Char>(['\u{0801}','\u{0802}'])
    let str1 = Utf8.size(String(str),0,1)
    let strr = Array<Char>(['\u{0799}','\u{dfff}'])
    let str2 = Utf8.size(String(strr),0,1)
    println(str2)
    if (str2 != 2) {
        return 1
    }
    return 0
}
