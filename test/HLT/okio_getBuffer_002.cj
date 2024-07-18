// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_getBuffer_002{

    @TestCase//getBuffer(): Buffer 获取buffer类 获取之后 可读
    func okio_getBuffer_002(): Unit {
        let buffer = Buffer()
        println(buffer.getBuffer() is Buffer)
        @Assert(buffer.getBuffer() is Buffer,true)

        buffer.write([6, 5, 4, 3, 2, 16, 7])
        println(buffer)
        println(buffer.getBuffer())
        @Assert(buffer.getBuffer().toString(),"[size=7] [6, 5, 4, 3, 2, 16, 7]")
        println(buffer.getBuffer() is Buffer)
        @Assert(buffer.getBuffer() is Buffer,true)
    }
    @TestCase
    func okio_getBuffer_002_2(): Unit {
        println("---------------------------------------------------------------")
        let buffer = Buffer()
        let source: Source = buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)

        println(bufferedSource)//???bug?
        // println(bufferedSource.request(3))
        println(bufferedSource.getBuffer())
        @Assert(bufferedSource.getBuffer().toString(),"[size=0] []")
        println(bufferedSource.getBuffer() is Buffer)
        @Assert(bufferedSource.getBuffer() is Buffer,true)
    }
}