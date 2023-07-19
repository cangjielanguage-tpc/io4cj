// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_hasArray_327 {

    @TestCase
    // 判断是否可通过一个可访问的 byte 数组实现此缓冲区。
    func nio_hasArray_327(): Unit {
        
        println("---------------------------nio_hasArray_327-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.hasArray()}")
    }
}