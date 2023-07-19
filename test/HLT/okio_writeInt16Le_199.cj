// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeInt16Le_199{

    @TestCase
    func okio_writeInt16Le_199(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt16Le(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [0, 0]")
    }
    @TestCase
    func okio_writeInt16Le_199_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt16Le(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=2] [0, 0]")
    }
}