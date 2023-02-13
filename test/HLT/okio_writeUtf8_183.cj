// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeUtf8_183{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_183(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeUtf8("hello world",6,11)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"[size=5] [119, 111, 114, 108, 100]")
    }
    @TestCase
    func okio_writeUtf8_183_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("hello world",6,11)
        println(bufferedSink.toString())
        // println(bufferedSink.buffer().readUtf8())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=5] [119, 111, 114, 108, 100]")
    
        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeUtf8("hello world",6,11)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}