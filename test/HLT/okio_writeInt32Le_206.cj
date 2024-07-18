// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeInt32Le_206{

    @TestCase
    func okio_writeInt32Le_206(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt32Le(4294967295)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=4] [255, 255, 255, 255]")
    }
    @TestCase
    func okio_writeInt32Le_206_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt32Le(4294967295)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=4] [255, 255, 255, 255]")
    }
}