// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_putUInt16_315{

    @TestCase
    // 存储一个 UInt16（二个字节），只支持 Big-Endian（大端）写入操作
    func nio_putUInt16_315(): Unit {
        
        println("---------------------------nio_putUInt16_315-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        var putUInt16return = byteBuffer.putUInt16(4369)
        var arr :Array<UInt8> = [17, 17, 1, 1, 1, 1, 1, 1, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putUInt16return : ${putUInt16return}")
        @Assert(putUInt16return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=3 cap=10]")
    }
    @TestCase
    func nio_putUInt16_315_2(): Unit {
        
        println("---------------------------nio_putUInt16_315_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putUInt16return = byteBuffer.putUInt16(4369)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 17, 17, 1, 1, 1, 1, 1, 1, 1]
        @Assert(byteBuffer.array(),arr)

        println("putUInt16return : ${putUInt16return}")
        @Assert(putUInt16return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=10]")
    }

    @TestCase
    func nio_putUInt16_315_3(): Unit {
        var exc = ""
        println("---------------------------nio_putUInt16_315_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,3)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putUInt16return = byteBuffer.putUInt16(4369)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}