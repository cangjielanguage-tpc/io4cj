// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_getLong_316{

    @TestCase
    // 获取一个 Int64 值（八个字节）
    func nio_getLong_316(): Unit {
        
        println("---------------------------nio_getLong_316-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getLongreturn = byteBuffer.getLong()
        
        println("array() : ${byteBuffer.array()}")

        println("getLongreturn : ${getLongreturn}")
        @Assert(getLongreturn,Int64(-1229782938247303441))

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
    }
    @TestCase
    func nio_getLong_316_2(): Unit {
        
        println("---------------------------nio_getLong_316_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getLongreturn = byteBuffer.getLong()

        println("getLongreturn : ${getLongreturn}")
        @Assert(getLongreturn,Int64(-1229782938247303423))

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
    }

    @TestCase
    func nio_getLong_316_3(): Unit {
        var exc = ""
        println("---------------------------nio_getLong_316_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getLongreturn = byteBuffer.getLong()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}