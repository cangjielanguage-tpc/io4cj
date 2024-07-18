// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeAll_180{

    @TestCase//向BufferedSink中写入一个完整source的字节序列
    func okio_writeAll_180(): Unit {
        let bufferedSink = Buffer()
        let source = Buffer()
        source.write("".toArray())
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_writeAll_180_2(): Unit {
        let buffer = Buffer()
        let source = Buffer()
        source.write("".toArray())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}