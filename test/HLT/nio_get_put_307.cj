// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_get_put_307{

    @TestCase
    // public func get(): UInt8 获取一个字节
    // public func put(b: UInt8): Buffer 存储一个字节
    func nio_get_put_307(): Unit {
        
        println("---------------------------nio_get_put_307-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        byteBuffer.put(123)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(0)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(255)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [123, 0, 0, 0, 255]
        @Assert(byteBuffer.array(),arr)

    }
    @TestCase
    func nio_get_put_307_2(): Unit {
        
        println("---------------------------nio_get_put_307_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        byteBuffer.put(123)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(0)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(255)
        println("array() : ${byteBuffer.array()}")

        
        try{
            byteBuffer.put(255)
        } catch (e:Exception){
            // e.printStackTrace()
            println(e.message)
        }
        println("array() : ${byteBuffer.array()}")
    }
    @TestCase
    func nio_get_put_307_3(): Unit {
        
        println("---------------------------nio_get_put_307_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        byteBuffer.put(123)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(0)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.get() : ${byteBuffer.get()}")

        byteBuffer.put(255)
        println("array() : ${byteBuffer.array()}")

        try{
            byteBuffer.get()
        } catch (e:Exception){
            // e.printStackTrace()
            println(e.message)
        }
        println("array() : ${byteBuffer.array()}")
    }
}