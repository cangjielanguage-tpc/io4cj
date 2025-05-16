// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf8_184{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_184(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeUtf8("",0,0)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_writeUtf8_184_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("",0,0)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}