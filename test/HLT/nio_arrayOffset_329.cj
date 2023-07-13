// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_arrayOffset_329 {

    @TestCase
    // 返回此缓冲区中的第一个元素在缓冲区的底层实现数组中的偏移量 （可选操作）。
    // 如果存在实现此缓冲区的数组，则缓冲区位置 p 对应于数组索引 p + arrayOffset()。
    // 调用此方法之前要调用 hasArray 方法，以确保此缓冲区具有可访问的底层实现数组。
    func nio_arrayOffset_329(): Unit {
        
        println("---------------------------nio_arrayOffset_329-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,9)
        println("array() : ${byteBuffer.array()}")

        println("arrayOffset() : ${byteBuffer.arrayOffset()}")

        // @Assert(arr,arr2)
        // arr[1] = 2
        // println("arr2 : ${arr2}")
        // @Assert(arr,arr2)

    }
}