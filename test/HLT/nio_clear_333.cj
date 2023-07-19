// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_clear_333 {

    @TestCase
    // 重置初始化状态。它通常用于清除操作。
    // 此方法的功能是所有状态都将返回到初始状态。position=0， mark=-1，limit=capacity；
    // 注意，此方法与flip的区别在于limit的值是不一样的。
    func nio_clear_333(): Unit {
        
        println("---------------------------nio_clear_333-----------------------------")
        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 238, 238, 238]
        var byteBuffer = ByteBuffer.wrap(arr,1,8)

        byteBuffer.mark()
        byteBuffer.get()
        byteBuffer.get()
        println("byteBuffer() : ${byteBuffer.toString()}")
        byteBuffer.clear()
        println("byteBuffer() : ${byteBuffer.toString()}")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=10]")
    }
}