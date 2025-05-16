// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeInt32_200{

    @TestCase
    func okio_writeInt32_200(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt32(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=4] [0, 0, 0, 0]")
    }
    @TestCase
    func okio_writeInt32_200_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt32(0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=4] [0, 0, 0, 0]")
    }
}