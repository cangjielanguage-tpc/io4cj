// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_write_175{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_175(): Unit {
        let bufferedSink = Buffer()
        let Source = Buffer()
        Source.write("hello world".toArray())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_write_175_2(): Unit {
        let buffer = Buffer()
        let source = Buffer()
        source.write("hello world".toArray())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.write(source,0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.write(source,1)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}