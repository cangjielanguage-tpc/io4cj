// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_write_175{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_175(): Unit {
        let bufferedSink = okio.Buffer()
        let Source = okio.Buffer()
        Source.write("hello world".toUtf8Array())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase
    func okio_write_175_2(): Unit {
        let buffer = okio.Buffer()
        let source = okio.Buffer()
        source.write("hello world".toUtf8Array())
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        bufferedSink.write(source,0)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.write(source,1)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}