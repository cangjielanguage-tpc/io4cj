// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_limit_331 {

    @TestCase
    // 设置此缓冲区的位置。如果标记(mark)已定义且大于新位置(newPosition)，则丢弃该标记(mark)
    func nio_limit_331(): Unit {
        
        println("---------------------------nio_limit_331-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,9)

        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.limit(3)
        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=3 cap=10]")

        byteBuffer.limit(0)
        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=0 cap=10]")


    }
}