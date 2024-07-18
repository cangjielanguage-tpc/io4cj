// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_write_174{

    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_174(): Unit {
        let bufferedSink = Buffer()
        let byteString: ByteString = ByteString("".toArray())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_174_2(): Unit {
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("".toArray())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}