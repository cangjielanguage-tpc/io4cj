// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_putShort_312{

    @TestCase
    // 存储一个 Int16（二个字节），只支持 Big-Endian（大端）写入操作
    func nio_putShort_312(): Unit {
        
        println("---------------------------nio_putShort_312-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        var putShortreturn = byteBuffer.putShort(-4369)
        var arr :Array<UInt8> = [238, 239, 1, 1, 1, 1, 1, 1, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putShortreturn : ${putShortreturn}")
        @Assert(putShortreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=3 cap=10]")
    }
    @TestCase
    func nio_putShort_312_2(): Unit {
        
        println("---------------------------nio_putShort_312_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putShortreturn = byteBuffer.putShort(-4369)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 238, 239, 1, 1, 1, 1, 1, 1, 1]
        @Assert(byteBuffer.array(),arr)

        println("putShortreturn : ${putShortreturn}")
        @Assert(putShortreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=10]")
    }

    @TestCase
    func nio_putShort_312_3(): Unit {
        var exc = ""
        println("---------------------------nio_putShort_312_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putShortreturn = byteBuffer.putShort(-4369)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}