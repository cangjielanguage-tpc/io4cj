// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_put_Array_325{

    @TestCase
    // 将给定src数组中的剩余字节传输到此缓冲区中。
    func nio_put_Array_325(): Unit {
        
        println("---------------------------nio_put_Array_325-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [0, 0, 0, 238, 238, 238, 238, 239, 1, 1]
        @Assert(byteBuffer.array(),arrR)
    }
    @TestCase
    func nio_put_Array_325_2(): Unit {
        
        println("---------------------------nio_put_Array_325_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(3,item:0))
    }
    @TestCase
    func nio_put_Array_325_3(): Unit {
        
        println("---------------------------nio_put_Array_325_3-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src,0,2)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=2 cap=2]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [0, 0]
        @Assert(byteBuffer.array(),arrR)
    }
    @TestCase
    func nio_put_Array_325_4(): Unit {
        
        println("---------------------------nio_put_Array_325_4-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,0,3)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_put_Array_325_5(): Unit {
        
        println("---------------------------nio_put_Array_325_5-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var src :Array<UInt8> = []
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,0,0)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)
    }
    @TestCase
    func nio_put_Array_325_6(): Unit {
        
        println("---------------------------nio_put_Array_325_6-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,0,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_put_Array_325_7(): Unit {
        
        println("---------------------------nio_put_Array_325_7-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src,2,1)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=4 cap=4]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [0, 1, 238, 0]
        @Assert(byteBuffer.array(),arrR)

    }
    @TestCase
    func nio_put_Array_325_8(): Unit {
        
        println("---------------------------nio_put_Array_325_8-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src,2,0)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=4 cap=4]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [238, 1, 238, 0]
        @Assert(byteBuffer.array(),arrR)
    }
    @TestCase
    func nio_put_Array_325_9(): Unit {
        
        println("---------------------------nio_put_Array_325_9-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,-1,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_put_Array_325_10(): Unit {
        
        println("---------------------------nio_put_Array_325_10-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,1,-1)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_put_Array_325_11(): Unit {
        
        println("---------------------------nio_put_Array_325_11-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src,1,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
}