// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_getShort_318{

    @TestCase
    // 获取一个 Int16 值（二个字节）
    func nio_getShort_318(): Unit {
        
        println("---------------------------nio_getShort_318-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getShortreturn = byteBuffer.getShort()
        
        println("array() : ${byteBuffer.array()}")

        println("getShortreturn : ${getShortreturn}")
        @Assert(getShortreturn,Int16(-4370))

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=9 cap=10]")
    }
    @TestCase
    func nio_getShort_318_2(): Unit {
        
        println("---------------------------nio_getShort_318_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getShortreturn = byteBuffer.getShort()

        println("getShortreturn : ${getShortreturn}")
        @Assert(getShortreturn,Int16(-4370))

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")
    }

    @TestCase
    func nio_getShort_318_3(): Unit {
        var exc = ""
        println("---------------------------nio_getShort_318_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getShortreturn = byteBuffer.getShort()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}