// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeUtf16_193{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf16_193(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt16(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [0, 0]")
    }
    @TestCase
    func okio_writeUtf16_193_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt16(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=2] [0, 0]")

    }
}