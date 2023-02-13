// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_putLong_310{

    @TestCase
    // 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
    func nio_putLong_310(): Unit {
        
        println("---------------------------nio_putLong_310-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        var putLongreturn = byteBuffer.putLong(-1229782938247303441)
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putLongreturn : ${putLongreturn}")
        @Assert(putLongreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=8 lim=9 cap=10]")
    }
    @TestCase
    // 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
    func nio_putLong_310_2(): Unit {
        
        println("---------------------------nio_putLong_310_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putLongreturn = byteBuffer.putLong(-1229782938247303441)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 238, 238, 238, 238, 238, 238, 238, 239, 1]
        @Assert(byteBuffer.array(),arr)

        println("putLongreturn : ${putLongreturn}")
        @Assert(putLongreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=9 lim=9 cap=10]")
    }

    @TestCase
    // 存储一个 Int64（八个字节），只支持 Big-Endian（大端）写入操作
    func nio_putLong_310_3(): Unit {
        var exc = ""
        println("---------------------------nio_putLong_310_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putLongreturn = byteBuffer.putLong(-1229782938247303441)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}