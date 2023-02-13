// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_getInt_317{

    @TestCase
    // 获取一个 Int32 值（四个字节）
    func nio_getInt_317(): Unit {
        
        println("---------------------------nio_getInt_317-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        var getIntreturn = byteBuffer.getInt()

        println("getIntreturn : ${getIntreturn}")
        @Assert(getIntreturn,Int32(-286331154))

        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=9 cap=10]")
    }
    @TestCase
    func nio_getInt_317_2(): Unit {
        
        println("---------------------------nio_getInt_317_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var getIntreturn = byteBuffer.getInt()

        println("getIntreturn : ${getIntreturn}")
        @Assert(getIntreturn,Int32(-286331154))

        println("byteBuffer : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=9 cap=10]")
    }

    @TestCase
    func nio_getInt_317_3(): Unit {
        var exc = ""
        println("---------------------------nio_getInt_317_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var byteBuffer = ByteBuffer.wrap(arr,0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var getIntreturn = byteBuffer.getInt()
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}