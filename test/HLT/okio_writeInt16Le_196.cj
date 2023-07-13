// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt16Le_196{

    @TestCase
    func okio_writeInt16Le_196(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt16Le(256)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=2] [0, 1]")
    }
    @TestCase
    func okio_writeInt16Le_196_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt16Le(256)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=2] [0, 1]")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeInt16Le(256)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}