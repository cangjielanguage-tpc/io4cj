// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_write_173{

    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_173(): Unit {
        let bufferedSink = okio.Buffer()
        let byteString: ByteString = ByteString("hello world".toUtf8Array())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_173_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("hello world".toUtf8Array())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")

        var exc = ""
        try{
            bufferedSink.close()
            bufferedSink.write(byteString)
        } catch (e:IllegalArgumentException){
            exc = e.message
            println("e.message : ${"IllegalArgumentException"}")
        }
        @Assert(exc,"closed.")
    }
}