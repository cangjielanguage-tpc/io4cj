// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_rewind_335 {

    @TestCase
    // 清零，一版用于写完之后的数据，想从起始位置开始读数据的情形
    // 把position设为0，mark设为-1，不改变limit的值。
    func nio_rewind_335(): Unit {
        
        println("---------------------------nio_rewind_335-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,8)

        byteBuffer.mark()
        byteBuffer.get()
        byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.rewind()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=9 cap=10]")
    }
    @TestCase
    func nio_rewind_335_2(): Unit {
        
        println("---------------------------nio_rewind_335_2-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,8)

        byteBuffer.mark()
        // byteBuffer.get()
        // byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.rewind()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=8 cap=10]")
    }
    @TestCase
    func nio_rewind_335_3(): Unit {
        
        println("---------------------------nio_rewind_335_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,10)

        byteBuffer.mark()
        byteBuffer.position(10)
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.rewind()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
    }
}