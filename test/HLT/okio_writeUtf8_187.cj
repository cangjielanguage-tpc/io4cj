// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeUtf8_187{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_187(): Unit {
        var exc = ""
        try{
            let bufferedSink = okio.Buffer()
            bufferedSink.writeUtf8("hello world",5,4)
            println(bufferedSink.toString())
            // println(bufferedSink.buffer().readUtf8())
        } catch (e:IllegalArgumentException){
            exc = e.message
            println(exc)
        }
        @Assert(exc.contains("endIndex < beginIndex: 4 < 5"),true)
    }
    @TestCase
    func okio_writeUtf8_187_2(): Unit {
        var exc = ""
        try{
            let buffer = okio.Buffer()
            let sink: Sink = buffer
            let bufferedSink: BufferedSink = Okio.buffer(sink)
            bufferedSink.writeUtf8("hello world",5,4)
            println(bufferedSink.toString())
            // println(bufferedSink.buffer().readUtf8())
        } catch (e:IllegalArgumentException){
            exc = e.message
            println(exc)
        }
        @Assert(exc.contains("endIndex < beginIndex: 4 < 5"),true)
    }
}