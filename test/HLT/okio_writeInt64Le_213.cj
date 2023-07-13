// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt64Le_213{

    @TestCase
    func okio_writeInt64Le_213(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt64Le(Int64.Max)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=8] [255, 255, 255, 255, 255, 255, 255, 127]")
    }
    @TestCase
    func okio_writeInt64Le_213_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64Le(Int64.Max)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [255, 255, 255, 255, 255, 255, 255, 127]")
    }
}