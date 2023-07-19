// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeAll_180{

    @TestCase//向BufferedSink中写入一个完整source的字节序列
    func okio_writeAll_180(): Unit {
        let bufferedSink = okio.Buffer()
        let source = okio.Buffer()
        source.write("".toUtf8Array())
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_writeAll_180_2(): Unit {
        let buffer = okio.Buffer()
        let source = okio.Buffer()
        source.write("".toUtf8Array())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}