// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_getUInt32_320{

    @TestCase
    // 获取一个 UInt32 值（四个字节）
    func nio_getUInt32_320(): Unit {
        
        println("---------------------------nio_getUInt32_320-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getUInt32return = byteBuffer.getUInt32()

        println("getUInt32return : ${getUInt32return}")
        @Assert(getUInt32return,UInt32(4008636142))

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=9 cap=10]")
    }
    @TestCase
    func nio_getUInt32_320_2(): Unit {
        
        println("---------------------------nio_getUInt32_320_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getUInt32return = byteBuffer.getUInt32()

        println("getUInt32return : ${getUInt32return}")
        @Assert(getUInt32return,UInt32(4008636142))

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=9 cap=10]")
    }

    @TestCase
    func nio_getUInt32_320_3(): Unit {
        var exc = ""
        println("---------------------------nio_getUInt32_320_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getUInt32return = byteBuffer.getUInt32()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}