// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt32_200{

    @TestCase
    func okio_writeInt32_200(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt32(4294967295)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=4] [255, 255, 255, 255]")
    }
    @TestCase
    func okio_writeInt32_200_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt32(4294967295)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=4] [255, 255, 255, 255]")
    }
}