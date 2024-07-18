// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_ForwardingSink_toString_220{

    // 需求修改 ForwardingSink 改成abstract 无法调用 只能删除部分用例
    // @TestCase //ForwardingSink toString接口
    // func okio_ForwardingSink_toString_220(): Unit {

    //     println("---------------------------okio_ForwardingSink_toString_220-----------------------------")

    //     let buffer = Buffer()
    //     let sink: Sink = buffer
    //     let bufferedSink: BufferedSink = Okio.buffer(sink)
    //     let byteString: ByteString = ByteString("hello world".toArray())
    //     bufferedSink.write(byteString)
    //     println(bufferedSink.toString())

    //     var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
    //     println(forwardingSink.toString())
    //     @Assert(forwardingSink.toString(),"Sink(RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100])")
    // }
    // @TestCase //ForwardingSink toString接口
    // func okio_ForwardingSink_toString_220_2(): Unit {
    //     println("---------------------------okio_ForwardingSink_toString_220_2-----------------------------")

    //     let bufferedSink = Buffer()
    //     let Source = Buffer()
    //     Source.write("hello world".toArray())
    //     bufferedSink.write(Source,0)
    //     println(bufferedSink.toString())

    //     var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
    //     println(forwardingSink.toString())
    //     @Assert(forwardingSink.toString(),"Sink([size=0] [])")
    
    // }
    @TestCase //ForwardingSink toString接口
    func okio_ForwardingSink_toString_220_3(): Unit {
        println("---------------------------okio_ForwardingSink_toString_220_3-----------------------------")

        let bufferedSink = Buffer()
        let Source = Buffer()
        Source.write("hello world".toArray())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())

        var forwardingSink : ForwardingSink = HashingSink.md5(bufferedSink)
        println(forwardingSink.toString())
        // @Assert(forwardingSink.toString(),"Sink([size=0] [])")
    
    }
}