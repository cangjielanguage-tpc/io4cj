// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeUtf16_192{

    @TestCase
    func okio_writeUtf16_192(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt16(256)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [1, 0]")
    }
    @TestCase
    func okio_writeUtf16_192_2(): Unit {
        let buffer = okio.Buffer()
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