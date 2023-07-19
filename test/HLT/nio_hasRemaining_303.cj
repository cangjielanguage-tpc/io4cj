// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_hasRemaining_303{

    @TestCase
    // 返回此缓冲区的容量。
    func nio_hasRemaining_303(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
        println("---------------------------nio_hasRemaining_303-----------------------------")
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),[])
    
        println("capacity() : ${byteBuffer.hasRemaining()}")
        @Assert(byteBuffer.hasRemaining(),false)

    }
    @TestCase
    // 返回此缓冲区的容量。
    func nio_hasRemaining_303_2(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),2,0)
        println("---------------------------nio_hasRemaining_303_2-----------------------------")
        println("array() : ${byteBuffer.array()}")
    
        println("capacity() : ${byteBuffer.hasRemaining()}")
        @Assert(byteBuffer.hasRemaining(),false)

    }
    @TestCase
    // 返回此缓冲区的容量。
    func nio_hasRemaining_303_3(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),2,1)
        println("---------------------------nio_hasRemaining_303_3-----------------------------")
        println("array() : ${byteBuffer.array()}")
    
        println("capacity() : ${byteBuffer.hasRemaining()}")
        @Assert(byteBuffer.hasRemaining(),true)

    }
}
 