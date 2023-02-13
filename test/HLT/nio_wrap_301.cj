// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_wrap_301{

    @TestCase
    // ByteBuffer类的主要入口函数.
    // 相当于wrap(array, 0, array.size)
    func nio_wrap_301(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0))
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
    func nio_wrap_301_2(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0))
        var arry = Array<UInt8>(5,item:0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")

        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_301_3(): Unit {
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=5]")

        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_301_4(): Unit {
        var arry : Array<UInt8> = [1,2,3,4,5,6,7,8,9,0]
        var byteBuffer = ByteBuffer.wrap(arry)
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

        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_301_5(): Unit {
        var arry : Array<UInt8> = Array<UInt8>(10,item:0)
        var byteBuffer = ByteBuffer.wrap(arry)
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

        byteBuffer.put(255)

        var arry2 : Array<UInt8> = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        println("arry : ${arry}")
        @Assert(arry,arry2)

        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry2)

        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),1)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),10)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=1 pos=1 lim=10 cap=10]")
        println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_301_6(): Unit {
        var arry : Array<UInt8> = Array<UInt8>(10,item:0)
        var byteBuffer = ByteBuffer.wrap(arry)
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

        arry.set(0,127)

        var arry2 : Array<UInt8> = [127, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        println("arry : ${arry}")
        @Assert(arry,arry2)

        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry2)

        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),10)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(), "ByteBuffer: [offset=0 mark=0 pos=0 lim=10 cap=10]")
        println("--------------------------------------------------------")
    }
}
 