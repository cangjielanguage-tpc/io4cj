// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_putUInt64_313{

    @TestCase
    // 存储一个 UInt64（八个字节），只支持 Big-Endian（大端）写入操作
    func nio_putUInt64_313(): Unit {
        
        println("---------------------------nio_putUInt64_313-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
        var arr :Array<UInt8> = [17, 17, 17, 17, 17, 17, 17, 17, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putUInt64return : ${putUInt64return}")
        @Assert(putUInt64return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
    }
    @TestCase
    func nio_putUInt64_313_2(): Unit {
        
        println("---------------------------nio_putUInt64_313_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 17, 17, 17, 17, 17, 17, 17, 17, 1]
        @Assert(byteBuffer.array(),arr)

        println("putUInt64return : ${putUInt64return}")
        @Assert(putUInt64return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
    }

    @TestCase
    func nio_putUInt64_313_3(): Unit {
        var exc = ""
        println("---------------------------nio_putUInt64_313_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putUInt64return = byteBuffer.putUInt64(1229782938247303441)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}