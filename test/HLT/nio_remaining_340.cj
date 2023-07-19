// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_remaining_340 {

    @TestCase
    // 返回limit和position之间相对位置差 
    func nio_remaining_340(): Unit {
        
        println("---------------------------nio_remaining_340-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)
        byteBuffer.position(5)

        println("byteBuffer() : ${byteBuffer.toString()}")
        println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
       
    }
    @TestCase
    func nio_remaining_340_2(): Unit {
        
        println("---------------------------nio_remaining_340_2-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)

        println("byteBuffer() : ${byteBuffer.toString()}")
        println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
       
    }
    @TestCase
    func nio_remaining_340_3(): Unit {
        
        println("---------------------------nio_remaining_340_3-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)
        byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        println("byteBuffer.remaining() : ${byteBuffer.remaining()}")
    }
   
}