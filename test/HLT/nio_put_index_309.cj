// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_put_index_309{

    @TestCase
    // 将给定字节写入此缓冲区的给定索引处。如果 index 为负或不小于缓冲区界限, 将抛出 IndexOutOfBoundsException 。
    func nio_put_index_309(): Unit {
        
        println("---------------------------nio_put_index_309-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))

        var num = byteBuffer.put(0,128)
        println("byteBuffer.put(0,128) : ${byteBuffer.array()}")

        num = byteBuffer.put(4,0)
        println("byteBuffer.put(4,0) : ${byteBuffer.array()}")

        println("byteBuffer.put(4,0) : ${byteBuffer.put(4,0)}")

        var arr :Array<UInt8> = [128, 1, 1, 1, 0]
        @Assert(byteBuffer.array(),arr)


    }
    @TestCase
    func nio_put_index_309_2(): Unit {
        
        var exc = ""
        println("---------------------------nio_put_index_309_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
        
        try{
            byteBuffer.put(5,255)
        } catch (e:IndexOutOfBoundsException){
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase
    func nio_put_index_309_3(): Unit {
        
        var exc = ""
        println("---------------------------nio_put_index_309_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
        
        try{
            byteBuffer.put(-1,255)
        } catch (e:IndexOutOfBoundsException){
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}