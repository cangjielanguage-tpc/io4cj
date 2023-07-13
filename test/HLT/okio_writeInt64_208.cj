// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt64_208{

    @TestCase
    func okio_writeInt64_208(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt64(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=8] [0, 0, 0, 0, 0, 1, 0, 0]")
    }
    @TestCase
    func okio_writeInt64_208_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt64(65536)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=8] [0, 0, 0, 0, 0, 1, 0, 0]")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeInt64(65536)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}