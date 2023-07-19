// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_write_176{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_176(): Unit {
        let bufferedSink = okio.Buffer()
        let source = okio.Buffer()
        source.write("hello world".toUtf8Array())
        bufferedSink.write(source,11)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
    @TestCase
    func okio_write_176_2(): Unit {
        let buffer = okio.Buffer()
        let source = okio.Buffer()
        source.write("hello world".toUtf8Array())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.write(source,11)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
}