// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeUtf8_188{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeInt8_188(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeInt8(123)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=1] [123]")
    }
    @TestCase
    func okio_writeInt8_188_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeInt8(123)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=1] [123]")
    
        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeInt8(123)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}