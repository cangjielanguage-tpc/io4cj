// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_write_178{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_178(): Unit {
        var exc = ""
        try{
            let bufferedSink = okio.Buffer()
            let source = okio.Buffer()
            source.write("hello world".toUtf8Array())
            bufferedSink.write(source,12)
            println(bufferedSink.toString())
        }catch (e:ArrayIndexOutOfBoundsException){
           println(e.message)
           exc = "ArrayIndexOutOfBoundsException"
        }
        @Assert(exc,"ArrayIndexOutOfBoundsException")
    }
    @TestCase
    func okio_write_178_2(): Unit {
        var exc = ""
        try{
            let buffer = okio.Buffer()
            let source = okio.Buffer()
            source.write("hello world".toUtf8Array())
            let sink: Sink = buffer
            let bufferedSink: BufferedSink = Okio.buffer(sink)
            bufferedSink.write(source,12)
            println(bufferedSink.toString())
        }catch (e:ArrayIndexOutOfBoundsException){
           println(e.message)
           exc = "ArrayIndexOutOfBoundsException"
        }
        @Assert(exc,"ArrayIndexOutOfBoundsException")

    }
}