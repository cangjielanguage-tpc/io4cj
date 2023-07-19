// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_array_328 {

    @TestCase
    // 返回支持此缓冲区的数组。
    // 此方法旨在允许更有效地将数组支持的缓冲区传递给本机代码。
    // 具体的实现子类会为该方法提供了更强类型的返回值。
    // 对该缓冲区内容的修改将导致返回数组的内容被修改，反之亦然。
    // 在调用此方法之前调用hasArray方法，以确保此缓冲区具有可访问的后备数组。
    func nio_array_328(): Unit {
        
        println("---------------------------nio_array_328-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var arr2 = byteBuffer.array()
        arr2[0] = 1
        println("array() : ${byteBuffer.array()}")

        @Assert(arr,arr2)
        arr[1] = 2
        println("arr2 : ${arr2}")
        @Assert(arr,arr2)

    }
}