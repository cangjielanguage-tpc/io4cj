// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_reset_332 {

    @TestCase
    // 将此缓冲区的位置重置为先前标记的位置，调用此方法既不会更改也不会丢弃标记的值。
    // 内部逻辑是把position设置成mark的值，相当于之前做过一个标记，现在要退回到之前标记的位置。
    func nio_reset_332(): Unit {
        
        println("---------------------------nio_reset_332-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)

        byteBuffer.mark()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.get()
        byteBuffer.get()
        println("position() : ${byteBuffer.position()}")
        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.position(),2)
        byteBuffer.reset()
        println("byteBuffer() : ${byteBuffer.toString()}")

        println("position() : ${byteBuffer.position()}")
        @Assert(byteBuffer.position(),0)
    }
}