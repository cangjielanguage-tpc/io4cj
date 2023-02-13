// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_getUInt16_321{

    @TestCase
    // 获取一个 UInt16 值（二个字节）
    func nio_getUInt16_321(): Unit {
        
        println("---------------------------nio_getUInt16_321-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getUInt16return = byteBuffer.getUInt16()
        
        println("array() : ${byteBuffer.array()}")

        println("getUInt16return : ${getUInt16return}")
        @Assert(getUInt16return,UInt16(61166))

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=9 cap=10]")
    }
    @TestCase
    func nio_getUInt16_321_2(): Unit {
        
        println("---------------------------nio_getUInt16_321_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getUInt16return = byteBuffer.getUInt16()

        println("getUInt16return : ${getUInt16return}")
        @Assert(getUInt16return,UInt16(61166))

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")
    }

    @TestCase
    func nio_getUInt16_321_3(): Unit {
        var exc = ""
        println("---------------------------nio_getUInt16_321_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getUInt16return = byteBuffer.getUInt16()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}