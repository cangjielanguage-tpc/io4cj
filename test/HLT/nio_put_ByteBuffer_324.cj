// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_put_ByteBuffer_324{

    @TestCase
    // 将给定src缓冲区中的剩余字节传输到此缓冲区中。
    func nio_put_ByteBuffer_324(): Unit {
        
        println("---------------------------nio_put_ByteBuffer_324-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(byteBuffer)}")
        } catch (e:IllegalArgumentException){
            // e.printStackTrace()
            exc = "IllegalArgumentException"
        }
        @Assert(exc,"IllegalArgumentException")
    }
    @TestCase
    func nio_put_ByteBuffer_324_2(): Unit {
        
        println("---------------------------nio_put_ByteBuffer_324_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

        println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

        println("byteBuffer.toString() : ${byteBuffer.toString()}")
        println("byteBuffer_new.toString() : ${byteBuffer_new.toString()}")

        @Assert(byteBuffer.array(),byteBuffer_new.array())

    }
    @TestCase
    func nio_put_ByteBuffer_324_3(): Unit {
        
        println("---------------------------nio_put_ByteBuffer_324_3-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

        println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

        println("byteBuffer.toString() : ${byteBuffer.toString()}")
        println("byteBuffer_new.toString() : ${byteBuffer_new.toString()}")

        var arrR :Array<UInt8> = [238, 238, 0]
        @Assert(arrR,byteBuffer_new.array())
    }
    @TestCase
    func nio_put_ByteBuffer_324_4(): Unit {
        
        println("---------------------------nio_put_ByteBuffer_324_4-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        var byteBuffer_new = ByteBuffer.wrap(Array<UInt8>(3,item:0),0,3)
        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer_new.array() : ${byteBuffer_new.array()}")

        byteBuffer_new.get()
        var exc = ""
        try{
            println("byteBuffer_new.put(byteBuffer) : ${byteBuffer_new.put(byteBuffer)}")
        } catch (e:Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
}