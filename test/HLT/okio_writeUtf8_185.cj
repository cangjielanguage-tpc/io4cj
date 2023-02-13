// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeUtf8_185{

    @TestCase//向BufferedSink中写入UTF-8编码的字符串.
    func okio_writeUtf8_185(): Unit {
        var exc = ""
        try{
            let bufferedSink = okio.Buffer()
            bufferedSink.writeUtf8("hello world",-1,11)
            println(bufferedSink.toString())
            // println(bufferedSink.buffer().readUtf8())
        } catch (e:IllegalArgumentException){
            exc = e.message
        }
        @Assert(exc.contains("beginIndex < 0: -1"),true)
    }
    @TestCase
    func okio_writeUtf8_185_2(): Unit {
        var exc = ""
        try{
            let buffer = okio.Buffer()
            let sink: Sink = buffer
            let bufferedSink: BufferedSink = Okio.buffer(sink)
            bufferedSink.writeUtf8("hello world",-1,11)
            println(bufferedSink.toString())
            // println(bufferedSink.buffer().readUtf8())
        } catch (e:IllegalArgumentException){
            exc = e.message
        }
        @Assert(exc.contains("beginIndex < 0: -1"),true)
    }
}