// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf16_192{

    @TestCase
    func okio_writeUtf16_192(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt16(256)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [1, 0]")
    }
    @TestCase
    func okio_writeUtf16_192_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt16(256)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=2] [1, 0]")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeInt16(256)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}