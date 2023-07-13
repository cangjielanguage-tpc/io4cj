// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_buffer_172{

    @TestCase//获取此BufferedSink的缓冲对象
    func okio_buffer_172(): Unit {
        let buffer = okio.Buffer()

        println(buffer.buffer() is Buffer)
        @Assert(buffer.buffer() is Buffer,true)
    }
    @TestCase
    func okio_buffer_172_2(): Unit {
        let buffer = okio.Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        
        println(bufferedSink.buffer() is Buffer)
        @Assert(bufferedSink.buffer() is Buffer,true)
        
        bufferedSink.close()
        println(bufferedSink.buffer() is Buffer)
        @Assert(bufferedSink.buffer() is Buffer,true)       
    }
}