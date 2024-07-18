// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_write_178{

    @TestCase//向BufferedSink中写入一个source中包含bytecount个的字节序列
    func okio_write_178(): Unit {
        var exc = ""
        try{
            let bufferedSink = Buffer()
            let source = Buffer()
            source.write("hello world".toArray())
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
            let buffer = Buffer()
            let source = Buffer()
            source.write("hello world".toArray())
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