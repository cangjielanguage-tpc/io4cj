// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_wrap_302{

    @TestCase
    // ByteBuffer类的主要入口函数.
    // 将 UInt8 数组包装到缓冲区中。新的缓冲区将由给定的 UInt8 数组支持。
    // 也就是说，缓冲区修改将导致数组修改，反之亦然。
    // 新缓冲区的容量将为array.length，其位置将为offset，其界限将为 offset + length，其标记是不确定的。
    // 其底层实现数组将为给定数组，并且其数组偏移量将为零。
    func nio_wrap_302(): Unit {
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
        println("---------------------------nio_wrap_302-----------------------------")
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

        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_2(): Unit {
        println("---------------------------nio_wrap_302_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,2)
        var arry = Array<UInt8>(5,item:0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),2)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=2 cap=5]")

        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_3(): Unit {
        println("---------------------------nio_wrap_302_3-----------------------------")
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,1,2)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),5)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),1)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),3)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=1 pos=1 lim=3 cap=5]")

        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_4(): Unit {
        println("---------------------------nio_wrap_302_4-----------------------------")
        var arry : Array<UInt8> = [1,2,3,4,5,6,7,8,9,0]
        var byteBuffer = ByteBuffer.wrap(arry,0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")

        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_5(): Unit {
        println("---------------------------nio_wrap_302_5-----------------------------")
        var arry : Array<UInt8> = Array<UInt8>(10,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,5,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),5)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),10)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=5 pos=5 lim=10 cap=10]")

        byteBuffer.put(255)

        var arry2 : Array<UInt8> = [0, 0, 0, 0, 0, 255, 0, 0, 0, 0]

        println("arry : ${arry}")
        @Assert(arry,arry2)

        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry2)

        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),6)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),10)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=6 pos=6 lim=10 cap=10]")
        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_6(): Unit {
        println("---------------------------nio_wrap_302_6-----------------------------")
        var arry : Array<UInt8> = Array<UInt8>(10,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arry)
    
        println("capacity() : ${byteBuffer.capacity()}")
        @Assert(byteBuffer.capacity(),10)
        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
        println("limit() : ${byteBuffer.limit()}")
        @Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")

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
        @Assert(byteBuffer.limit(),5)
        println("mark() : ${byteBuffer.mark()}")
        @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 mark=0 pos=0 lim=5 cap=10]")
        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_7(): Unit {
        println("---------------------------nio_wrap_302_7-----------------------------")
        var arry = Array<UInt8>(5,item:0)
        var byteBuffer = ByteBuffer.wrap(arry,0,5)
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

        // println("--------------------------------------------------------")
    }
    @TestCase
    func nio_wrap_302_8(): Unit {
        println("---------------------------nio_wrap_302_8-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,5,5)
            println("array() : ${byteBuffer.array()}")
            @Assert(byteBuffer.array(),arry)
        
            println("capacity() : ${byteBuffer.capacity()}")
            @Assert(byteBuffer.capacity(),5)
            println("position() : ${byteBuffer.position()}")
            @Assert(byteBuffer.position(),0)
            println("limit() : ${byteBuffer.limit()}")
            @Assert(byteBuffer.limit(),5)
            println("mark() : ${byteBuffer.mark()}")
            @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
    @TestCase
    func nio_wrap_302_9(): Unit {
        println("---------------------------nio_wrap_302_9-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,6,6)
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
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
    @TestCase
    func nio_wrap_302_10(): Unit {
        println("---------------------------nio_wrap_302_10-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,-1,5)
            println("array() : ${byteBuffer.array()}")
            @Assert(byteBuffer.array(),arry)
        
            println("capacity() : ${byteBuffer.capacity()}")
            @Assert(byteBuffer.capacity(),5)
            println("position() : ${byteBuffer.position()}")
            @Assert(byteBuffer.position(),0)
            println("limit() : ${byteBuffer.limit()}")
            @Assert(byteBuffer.limit(),5)
            println("mark() : ${byteBuffer.mark()}")
            @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0  mark=0 pos=0 lim=5 cap=5]")
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
    @TestCase
    func nio_wrap_302_11(): Unit {
        println("---------------------------nio_wrap_302_11-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,0,-1)
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
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
    @TestCase
    func nio_wrap_302_12(): Unit {
        println("---------------------------nio_wrap_302_12-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,2,3)
            println("array() : ${byteBuffer.array()}")
            // @Assert(byteBuffer.array(),arry)
        
            println("capacity() : ${byteBuffer.capacity()}")
            // @Assert(byteBuffer.capacity(),5)
            println("position() : ${byteBuffer.position()}")
            // @Assert(byteBuffer.position(),0)
            println("limit() : ${byteBuffer.limit()}")
            // @Assert(byteBuffer.limit(),5)
            println("mark() : ${byteBuffer.mark()}")
            // @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
        @TestCase
    func nio_wrap_302_13(): Unit {
        println("---------------------------nio_wrap_302_13-----------------------------")
        var exc = ""
        try{
            var arry = Array<UInt8>(5,item:0)
            var byteBuffer = ByteBuffer.wrap(arry,2,4)
            println("array() : ${byteBuffer.array()}")
            // @Assert(byteBuffer.array(),arry)
        
            println("capacity() : ${byteBuffer.capacity()}")
            // @Assert(byteBuffer.capacity(),5)
            println("position() : ${byteBuffer.position()}")
            // @Assert(byteBuffer.position(),0)
            println("limit() : ${byteBuffer.limit()}")
            // @Assert(byteBuffer.limit(),5)
            println("mark() : ${byteBuffer.mark()}")
            // @Assert(byteBuffer.mark().toString(),"ByteBuffer: [offset=0 pos=0 lim=5 cap=5]")
        } catch (e:Exception) {
            // println(e.printStackTrace())
            println("e.message : ${e.message}")
            
        }
    }
}
 