// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_buffer_172{

    @TestCase//获取此BufferedSink的缓冲对象
    func okio_buffer_172(): Unit {
        let buffer = Buffer()

        println(buffer.buffer() is Buffer)
        @Assert(buffer.buffer() is Buffer,true)
    }
    @TestCase
    func okio_buffer_172_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        
        println(bufferedSink.buffer() is Buffer)
        @Assert(bufferedSink.buffer() is Buffer,true)
        
        bufferedSink.close()
        println(bufferedSink.buffer() is Buffer)
        @Assert(bufferedSink.buffer() is Buffer,true)       
    }
}