// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt16Le_198{

    @TestCase
    func okio_writeInt16Le_198(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt16Le(65535)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [255, 255]")
    }
    @TestCase
    func okio_writeInt16Le_198_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt16Le(65535)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=2] [255, 255]")
    }
}