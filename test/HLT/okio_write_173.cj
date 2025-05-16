// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_write_173{

    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_173(): Unit {
        let bufferedSink = Buffer()
        let byteString: ByteString = ByteString("hello world".toArray())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]")
    }
    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_173_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("hello world".toArray())
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