// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_get_index_308{

    @TestCase
    // 读取指定索引处的字节。 
    func nio_get_index_308(): Unit {
        
        println("---------------------------nio_get_index_308-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))

        var num = byteBuffer.get(0)
        println("byteBuffer.get(0) : ${num}")

        num = byteBuffer.get(4)
        println("byteBuffer.get(4) : ${num}")

    }
    @TestCase
    func nio_get_index_308_2(): Unit {
        
        var exc = ""
        println("---------------------------nio_get_index_308_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
        
        try{
            byteBuffer.get(5)
        } catch (e:IndexOutOfBoundsException){
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase
    func nio_get_index_308_3(): Unit {
        
        var exc = ""
        println("---------------------------nio_get_index_308_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:1),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:1))
        
        try{
            byteBuffer.get(-1)
        } catch (e:IndexOutOfBoundsException){
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}