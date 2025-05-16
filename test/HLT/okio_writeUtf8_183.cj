// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf8_183{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_183(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeUtf8("hello world",6,11)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"[size=5] [119, 111, 114, 108, 100]")
    }
    @TestCase
    func okio_writeUtf8_183_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("hello world",6,11)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=5] [119, 111, 114, 108, 100]")
    
        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeUtf8("hello world",6,11)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}