// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_write_177{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_177(): Unit {
        var exc = ""
        try{
            let bufferedSink = okio.Buffer()
            let source = okio.Buffer()
            source.write("hello world".toArray())
            bufferedSink.write(source,-1)
            println(bufferedSink.toString())
        }catch (e:ArrayIndexOutOfBoundsException){
           println(e.message)
           exc = "ArrayIndexOutOfBoundsException"
        }
        @Assert(exc,"ArrayIndexOutOfBoundsException")
    }
    @TestCase
    func okio_write_177_2(): Unit {
        var exc = ""
        try{
            let buffer = okio.Buffer()
            let source = okio.Buffer()
            source.write("hello world".toArray())
            let sink: Sink = buffer
            let bufferedSink: BufferedSink = Okio.buffer(sink)
            bufferedSink.write(source,-1)
            println(bufferedSink.toString())
        }catch (e:ArrayIndexOutOfBoundsException){
           println(e.message)
           exc = "ArrayIndexOutOfBoundsException"
        }
        @Assert(exc,"ArrayIndexOutOfBoundsException")

    }
}