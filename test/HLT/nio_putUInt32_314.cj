// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_putUInt32_314{

    @TestCase
    // 存储一个 UInt32（四个字节），只支持 Big-Endian（大端）写入操作
    func nio_putUInt32_314(): Unit {
        
        println("---------------------------nio_putUInt32_314-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        var putUInt32return = byteBuffer.putUInt32(286331153)
        var arr :Array<UInt8> = [17, 17, 17, 17, 1, 1, 1, 1, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putUInt32return : ${putUInt32return}")
        @Assert(putUInt32return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=5 cap=10]")
    }
    @TestCase
    func nio_putUInt32_314_2(): Unit {
        
        println("---------------------------nio_putUInt32_314_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putUInt32return = byteBuffer.putUInt32(286331153)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 17, 17, 17, 17, 1, 1, 1, 1, 1]
        @Assert(byteBuffer.array(),arr)

        println("putUInt32return : ${putUInt32return}")
        @Assert(putUInt32return.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=5 cap=10]")
    }

    @TestCase
    func nio_putUInt32_314_3(): Unit {
        var exc = ""
        println("---------------------------nio_putUInt32_314_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putUInt32return = byteBuffer.putUInt32(286331153)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}