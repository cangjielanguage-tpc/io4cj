// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_write_174{

    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_174(): Unit {
        let bufferedSink = okio.Buffer()
        let byteString: ByteString = ByteString("".toUtf8Array())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"[size=0] []")
    }
    @TestCase//向BufferedSink中写入一个完整的ByteString所包含的字节序列3
    func okio_write_174_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("".toUtf8Array())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        @Assert(bufferedSink.toString(),"RealBufferedSink: [size=0] []")
    }
}