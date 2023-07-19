// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeUtf8_181{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_181(): Unit {
        let bufferedSink = okio.Buffer()
        bufferedSink.writeUtf8("hello world")
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
    @TestCase
    func okio_writeUtf8_181_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.writeUtf8("hello world")
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    
        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.writeUtf8("hello world")
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}