// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_allocate_300{

    @TestCase
    // ByteBuffer类的主要入口函数.
    // 分配一个新的字节缓冲区。新缓冲区的位置将为零，其界限将为其容量，其标记是不确定的。
    // 它将具有一个底层实现数组，且其数组偏移量将为零。
    func nio_allocate_300(): Unit {
        var byteBuffer = ByteBuffer.allocate(0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),[])
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),0)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),0)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=0 cap=0]")

        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_allocate_300_2(): Unit {
        var byteBuffer = ByteBuffer.allocate(1)
        var arry = Array<UInt8>(1,item:0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),1)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),1)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=1 cap=1]")

        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_allocate_300_3(): Unit {
        try{
            var byteBuffer = ByteBuffer.allocate(-1)
            println("array() : ${byteBuffer.array()}")

            println("capacity() : ${byteBuffer.capacity()}")
            println("position() : ${byteBuffer.position()}")
            println("limit() : ${byteBuffer.limit()}")
            println("mark() : ${byteBuffer.mark()}")
        } catch (e : IllegalArgumentException){
            // println(e.printStackTrace())  
            println("e.message : ${e.message}")//提单
        }
        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_allocate_300_4(): Unit {
        var byteBuffer = ByteBuffer.allocate(10)
        var arry = Array<UInt8>(10,item:0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),10)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")
    }
}