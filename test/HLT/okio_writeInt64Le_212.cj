// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeInt64Le_212{

    @TestCase
    func okio_writeInt64Le_212(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt64Le(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=8] [0, 0, 0, 0, 0, 0, 0, 0]")
    }
    @TestCase
    func okio_writeInt64Le_212_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64Le(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [0, 0, 0, 0, 0, 0, 0, 0]")
    }
}