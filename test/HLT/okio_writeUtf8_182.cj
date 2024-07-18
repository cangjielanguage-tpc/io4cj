// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf8_182{

    @TestCase//向BufferedSink中写入一个完整source的字节序列
    func okio_writeUtf8_182(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeUtf8("")
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func ookio_writeUtf8_182_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("")
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}