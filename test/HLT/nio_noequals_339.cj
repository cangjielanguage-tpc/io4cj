// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_noequals_339 {

    @TestCase
    // 判断两个ByteBuffer是否是一个对象
    func nio_noequals_339(): Unit {
        
        println("---------------------------nio_noequals_339-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)

        var byteBuffer2 = byteBuffer
        println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
        @Assert(byteBuffer2 != byteBuffer,false)
       
    }
    @TestCase
    func nio_noequals_339_2(): Unit {
        
        println("---------------------------nio_noequals_339_2-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)

        var byteBuffer2 = ByteBuffer.wrap(arr,0,5)
        println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
        @Assert(byteBuffer2 != byteBuffer,true)
       
    }
    @TestCase
    func nio_noequals_339_3(): Unit {
        
        println("---------------------------nio_noequals_339_3-----------------------------")
        var arr :Array<UInt8> = [1, 2, 3, 4, 5]
        var arr2 :Array<UInt8> = [1, 2, 3, 4, 5]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)

        var byteBuffer2 = ByteBuffer.wrap(arr2,0,5)
        println("byteBuffer2 != byteBuffer : ${byteBuffer2 != byteBuffer}")
        @Assert(byteBuffer2 != byteBuffer,true)
    }
   
}