// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeUtf8_184{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_184(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeUtf8("",0,0)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_writeUtf8_184_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("",0,0)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}