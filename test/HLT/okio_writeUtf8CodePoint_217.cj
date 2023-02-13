// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeUtf8CodePoint_217{

    @TestCase
    func okio_writeUtf8CodePoint_217(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeUtf8CodePoint(0)
        // println(bufferedSink.readUtf8().getOrThrow())
        @Assert(bufferedSink.toString(),"[size=1] [0]")
    }
    @TestCase
    func okio_writeUtf8CodePoint_217_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8CodePoint(0)
        // println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=1] [0]")
    }
}