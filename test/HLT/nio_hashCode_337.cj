// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_hashCode_337 {

    @TestCase
    // 返回此ByteBuffer的哈希值
    func nio_hashCode_337(): Unit {
        
        println("---------------------------nio_hashCode_337-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)

        println("byteBuffer() : ${byteBuffer.toString()}")
        println("array() : ${byteBuffer.array()}")
        println("hashCode : ${byteBuffer.hashCode()}")
        // @Assert(byteBuffer.hashCode(),1088)
       
    }
    // @TestCase
    // func nio_hashCode_337_2(): Unit {
        
    //     println("---------------------------nio_hashCode_337_2-----------------------------")
    //     var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    //     var byteBuffer = ByteBuffer.wrap(arr,0,4)

    //     byteBuffer.position(2)
    //     println("byteBuffer() : ${byteBuffer.toString()}")
    //     println("array() : ${byteBuffer.array()}")
    //     byteBuffer.compact()
    //     println("byteBuffer() : ${byteBuffer.toString()}")
    //     println("array() : ${byteBuffer.array()}")

    //     var arrR :Array<UInt8> =  [3, 4, 3, 4, 5]
    //     @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 pos=2 lim=5 cap=5]")
    //     @Assert(byteBuffer.array(),arrR)
    // }
    // @TestCase
    // func nio_hashCode_337_3(): Unit {
        
    //     println("---------------------------nio_hashCode_337_3-----------------------------")
    //     var arr :Array<UInt8> = [1, 2, 3, 4, 5]
    //     var byteBuffer = ByteBuffer.wrap(arr,0,0)

    //     byteBuffer.position(0)
    //     println("byteBuffer() : ${byteBuffer.toString()}")
    //     println("array() : ${byteBuffer.array()}")
    //     byteBuffer.compact()
    //     println("byteBuffer() : ${byteBuffer.toString()}")
    //     println("array() : ${byteBuffer.array()}")


    //     @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
    //     @Assert(byteBuffer.array(),arr)
    // }
}