// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeUtf8CodePoint_216{

    @TestCase
    func okio_writeUtf8CodePoint_216(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeUtf8CodePoint(91)
        // println(bufferedSink.readUtf8().getOrThrow())
        @Assert(bufferedSink.readUtf8(),"[")
    }
    @TestCase
    func okio_writeUtf8CodePoint_216_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8CodePoint(91)
        // println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=1] [91]")
    
        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeUtf8CodePoint(91)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    
    }
}