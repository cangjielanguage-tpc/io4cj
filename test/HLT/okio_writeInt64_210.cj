// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.math.*
import io4cj.*

@Test
public class okio_writeInt64_210{

    @TestCase
    func okio_writeInt64_210(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt64(Int64.Max)
        println(bufferedSink.toString())
        // println(bufferedSink.readInt64())
        @Assert(bufferedSink.toString(),"[size=8] [127, 255, 255, 255, 255, 255, 255, 255]")
    }
    @TestCase
    func okio_writeInt64_210_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64(Int64.Max)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [127, 255, 255, 255, 255, 255, 255, 255]")
    }
}