// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_position_330 {

    @TestCase
    // 设置此缓冲区的位置。如果标记(mark)已定义且大于新位置(newPosition)，则丢弃该标记(mark)
    func nio_position_330(): Unit {
        
        println("---------------------------nio_position_330-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,9)

        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.position(3)
        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=10 cap=10]")

        byteBuffer.position(0)
        println("byteBuffer() : ${byteBuffer.toString()}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")


    }
}