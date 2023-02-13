// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_asReadOnlyBuffer_306{

    @TestCase
    // 实现此缓冲区的数组返回新的字节缓冲区
    // 新缓冲区的内容将从此缓冲区的当前位置开始。
    // 此缓冲区内容的更改在新缓冲区中是可见的，反之亦然；这两个缓冲区的位置、界限和标记值是相互独立的。
    // 新缓冲区的位置将为零，其容量和界限将为此缓冲区中所剩余的字节数量，其标记是不确定的。
    // 当且仅当此缓冲区为直接时，新缓冲区才是直接的，当且仅当此缓冲区为只读时，新缓冲区才是只读的。
    func nio_asReadOnlyBuffer_306(): Unit {
        
        println("---------------------------nio_asReadOnlyBuffer_306-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),[])
    
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer.asReadOnlyBuffer()}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer.asReadOnlyBuffer()}","${byteBuffer}")
        // @Assert(byteBuffer.asReadOnlyBuffer(),byteBuffer)
    }
    @TestCase
    func nio_asReadOnlyBuffer_306_2(): Unit {
        
        println("---------------------------nio_asReadOnlyBuffer_306_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer.asReadOnlyBuffer()}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer.asReadOnlyBuffer()}","${byteBuffer}")
        // @Assert(byteBuffer.asReadOnlyBuffer(),byteBuffer)

        println("byteBuffer isReadOnly? : ${byteBuffer.isReadOnly()}")
        println("byteBuffer.asReadOnlyBuffer() isReadOnly? : ${byteBuffer.asReadOnlyBuffer().isReadOnly()}")
        @Assert(byteBuffer.isReadOnly(),byteBuffer.asReadOnlyBuffer().isReadOnly())
    }
    @TestCase
    func nio_asReadOnlyBuffer_306_3(): Unit {
        
        println("---------------------------nio_asReadOnlyBuffer_306_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        var byteBuffer1 = byteBuffer.asReadOnlyBuffer()
    
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

        byteBuffer.put(123)

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer.asReadOnlyBuffer().array() : ${byteBuffer1.array()}")
        @Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")
        
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
        @Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

    } 
    @TestCase
    func nio_asReadOnlyBuffer_306_4(): Unit {
        
        println("---------------------------nio_asReadOnlyBuffer_306_4-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
        println("array() : ${byteBuffer.array()}")
        // @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        var byteBuffer1 = byteBuffer.asReadOnlyBuffer()

        println("byteBuffer.isDirect() : ${byteBuffer.isDirect()}")
        println("byteBuffer1.isDirect() : ${byteBuffer1.isDirect()}")
        @Assert(byteBuffer.isDirect(),byteBuffer1.isDirect())

        println("byteBuffer.isReadOnly() : ${byteBuffer.isReadOnly()}")
        println("byteBuffer1.isReadOnly() : ${byteBuffer1.isReadOnly()}")   
        // @Assert(byteBuffer.isReadOnly(),byteBuffer1.isReadOnly())
    
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")

        byteBuffer1.put(123)

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer.asReadOnlyBuffer().array() : ${byteBuffer1.array()}")
        @Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=5]")
        
        println("byteBuffer.asReadOnlyBuffer() : ${byteBuffer1}")
        @Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=5]")

    }
}