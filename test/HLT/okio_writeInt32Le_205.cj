// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeInt32Le_205{

    @TestCase
    func okio_writeInt32Le_205(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt32Le(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=4] [0, 0, 0, 0]")
    }
    @TestCase
    func okio_writeInt32Le_205_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt32Le(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=4] [0, 0, 0, 0]")
    }
}