// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeInt64Le_211{

    @TestCase
    func okio_writeInt64Le_211(): Unit {
        let bufferedSink = Buffer()
        bufferedSink.writeInt64Le(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=8] [0, 0, 1, 0, 0, 0, 0, 0]")
    }
    @TestCase
    func okio_writeInt64Le_211_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64Le(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [0, 0, 1, 0, 0, 0, 0, 0]")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeInt64Le(65536)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}