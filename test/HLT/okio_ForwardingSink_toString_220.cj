// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_ForwardingSink_toString_220{

    // 需求修改 ForwardingSink 改成abstract 无法调用 只能删除部分用例
    // @TestCase //ForwardingSink toString接口
    // func okio_ForwardingSink_toString_220(): Unit {

    //     println("---------------------------okio_ForwardingSink_toString_220-----------------------------")

    //     let buffer = okio.Buffer()
    //     let sink: Sink = buffer
    //     let bufferedSink: BufferedSink = Okio.buffer(sink)
    //     let byteString: ByteString = ByteString("hello world".toUtf8Array())
    //     bufferedSink.write(byteString)
    //     println(bufferedSink.toString())

    //     var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
    //     println(forwardingSink.toString())
    //     @Assert(forwardingSink.toString(),"Sink(RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100])")
    // }
    // @TestCase //ForwardingSink toString接口
    // func okio_ForwardingSink_toString_220_2(): Unit {
    //     println("---------------------------okio_ForwardingSink_toString_220_2-----------------------------")

    //     let bufferedSink = okio.Buffer()
    //     let Source = okio.Buffer()
    //     Source.write("hello world".toUtf8Array())
    //     bufferedSink.write(Source,0)
    //     println(bufferedSink.toString())

    //     var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
    //     println(forwardingSink.toString())
    //     @Assert(forwardingSink.toString(),"Sink([size=0] [])")
    
    // }
    @TestCase //ForwardingSink toString接口
    func okio_ForwardingSink_toString_220_3(): Unit {
        println("---------------------------okio_ForwardingSink_toString_220_3-----------------------------")

        let bufferedSink = okio.Buffer()
        let Source = okio.Buffer()
        Source.write("hello world".toUtf8Array())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())

        var forwardingSink : ForwardingSink = HashingSink.md5(bufferedSink)
        println(forwardingSink.toString())
        // @Assert(forwardingSink.toString(),"Sink([size=0] [])")
    
    }
}