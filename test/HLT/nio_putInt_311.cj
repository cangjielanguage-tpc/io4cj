// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_putInt_311{

    @TestCase
    // 存储一个 Int32（四个字节），只支持 Big-Endian（大端）写入操作
    func nio_putInt_311(): Unit {
        
        println("---------------------------nio_putInt_311-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        var putIntreturn = byteBuffer.putInt(-286331153)
        var arr :Array<UInt8> = [238, 238, 238, 239, 1, 1, 1, 1, 1, 1]
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),arr)

        println("putIntreturn : ${putIntreturn}")
        @Assert(putIntreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=4 lim=5 cap=10]")
    }
    @TestCase
    func nio_putInt_311_2(): Unit {
        
        println("---------------------------nio_putInt_311_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        var putIntreturn = byteBuffer.putInt(-286331153)
        println("array() : ${byteBuffer.array()}")
        var arr :Array<UInt8> = [1, 238, 238, 238, 239, 1, 1, 1, 1, 1]
        @Assert(byteBuffer.array(),arr)

        println("putIntreturn : ${putIntreturn}")
        @Assert(putIntreturn.toString(),"ByteBuffer: [offset=0 mark=-1 pos=5 lim=5 cap=10]")
    }

    @TestCase
    func nio_putInt_311_3(): Unit {
        var exc = ""
        println("---------------------------nio_putInt_311_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(10,item:1),0,5)
        println("array() : ${byteBuffer.array()}")

        byteBuffer.get()
        byteBuffer.get()
        try {
            var putIntreturn = byteBuffer.putInt(-286331153)
        } catch (e:Exception) {
            // e.printStackTrace()
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
}