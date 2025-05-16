// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf8CodePoint_217{

    @TestCase
    func okio_writeUtf8CodePoint_217(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeUtf8CodePoint(0)
        // println(bufferedSink.readUtf8().getOrThrow())
        @Assert(bufferedSink.toString(),"[size=1] [0]")
    }
    @TestCase
    func okio_writeUtf8CodePoint_217_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8CodePoint(0)
        // println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=1] [0]")
    }
}