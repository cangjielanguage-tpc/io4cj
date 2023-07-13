// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_getUInt64_319{

    @TestCase
    // 获取一个 UInt64 值（八个字节）
    func nio_getUInt64_319(): Unit {
        
        println("---------------------------nio_getUInt64_319-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getUInt64return = byteBuffer.getUInt64()
        
        println("array() : ${byteBuffer.array()}")

        println("getUInt64return : ${getUInt64return}")

        let a:UInt64 = 0xEEEEEEEEEEEEEEEF
        println("0xEEEEEEEEEEEEEEEF : ${a}")
        @Assert(getUInt64return,a)

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
    }
    @TestCase
    func nio_getUInt64_319_2(): Unit {
        
        println("---------------------------nio_getUInt64_319_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getUInt64return = byteBuffer.getUInt64()

        println("getUInt64return : ${(getUInt64return)}")
        let a:UInt64 = 0xEEEEEEEEEEEEEF01
        println("0xEEEEEEEEEEEEEEEF : ${a}")
        @Assert(getUInt64return,a)

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
    }

    @TestCase
    func nio_getUInt64_319_3(): Unit {
        var exc = ""
        println("---------------------------nio_getUInt64_319_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getUInt64return = byteBuffer.getUInt64()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}