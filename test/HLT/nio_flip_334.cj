// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_flip_334 {

    @TestCase
    // 翻转状态，将一个处于存数据状态的缓冲区变为一个处于准备取数据的状态，
    // 也就是让flip之后的position到limit这块区域变成之前的0到position这块
    // limit = position;position = 0;mark = -1;
    func nio_flip_334(): Unit {
        
        println("---------------------------nio_flip_334-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,8)

        byteBuffer.mark()
        byteBuffer.get()
        byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.flip()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=10]")
    }
    @TestCase
    func nio_flip_334_2(): Unit {
        
        println("---------------------------nio_flip_334_2-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,8)

        byteBuffer.mark()
        // byteBuffer.get()
        // byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.flip()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=0 cap=10]")
    }
    @TestCase
    func nio_flip_334_3(): Unit {
        
        println("---------------------------nio_flip_334_3-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,10)

        byteBuffer.mark()
        byteBuffer.position(10)
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.flip()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
    }
}