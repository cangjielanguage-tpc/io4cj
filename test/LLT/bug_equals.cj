// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*


// https://gitee.com/HW-PLLab/okio/issues/I5Y7RC

main () {
    let bs = ByteString("hello world".toUtf8Array())
    let bs2 = ByteString("hello world1".toUtf8Array())
    if (bs == bs2) {
        return 1
    }
    if (bs != bs2) {
        return 0
    }
    return 1
}