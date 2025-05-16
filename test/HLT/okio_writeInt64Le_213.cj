// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.math.*
import io4cj.*

@Test
public class okio_writeInt64Le_213{

    @TestCase
    func okio_writeInt64Le_213(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt64Le(Int64.Max)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=8] [255, 255, 255, 255, 255, 255, 255, 127]")
    }
    @TestCase
    func okio_writeInt64Le_213_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64Le(Int64.Max)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [255, 255, 255, 255, 255, 255, 255, 127]")
    }
}