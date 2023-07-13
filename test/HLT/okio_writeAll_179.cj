// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeAll_179{

    @TestCase//向BufferedSink中写入一个完整source的字节序列
    func okio_writeAll_179(): Unit {
        let bufferedSink = okio.Buffer()
        let source = okio.Buffer()
        source.write("hello world".toUtf8Array())
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
    @TestCase
    func okio_writeAll_179_2(): Unit {
        let buffer = okio.Buffer()
        let source = okio.Buffer()
        source.write("hello world".toUtf8Array())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeAll(source)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
}