// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.math.*
import io4cj.*

@Test
public class okio_gzip_sink_401 {

    @TestCase //ForwardingSink toString接口
    func okio_ForwardingSink_toString_220(): Unit {

        println("---------------------------okio_ForwardingSink_toString_220-----------------------------")

        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("hello world".toArray())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())

        var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
        println(forwardingSink.toString())
        @Assert(forwardingSink.toString(),"Sink(RealBufferedSink: [size=11] [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100])")
    }
    @TestCase //ForwardingSink toString接口
    func okio_ForwardingSink_toString_220_2(): Unit {
        println("---------------------------okio_ForwardingSink_toString_220_2-----------------------------")

        let bufferedSink = Buffer()
        let Source = Buffer()
        Source.write("hello world".toArray())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())

        var forwardingSink : ForwardingSink = ForwardingSink(bufferedSink)
        forwardingSink.write(Source,0)
        
        var exc = ""
        try{
        forwardingSink.isClosed()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc , "isClosed not support." )

        var exce = ""
        try{
        forwardingSink.timeout()
        }catch(e: Exception){
            exce = e.message
        }
        @Assert(exce , "" )

        var ex = ""
        try{
        forwardingSink.close()
        }catch(e: Exception){
            ex = e.message
        }
        @Assert(ex , "" )

        var ex1 = ""
        try{
        forwardingSink.flush()
        }catch(e: Exception){
            ex1 = e.message
        }
        @Assert(ex1 , "" )

        var ex2 = ""
        try{
        forwardingSink.delegate()
        }catch(e: Exception){
            ex2 = e.message
        }
        @Assert(ex2 , "" )
        println(forwardingSink.delegate())
        @Assert(forwardingSink.toString(),"Sink([size=0] [])")
    
    }

    @TestCase //ForwardingSink toString接口
    func okio_ForwardingSource_toString_220_3(): Unit {
        println("---------------------------okio_ForwardingSink_toString_220_2-----------------------------")

        let bufferedSink = Buffer()
        let Source = Buffer()
        Source.write("hello world".toArray())
        bufferedSink.write(Source,0)
        println(bufferedSink.toString())

        var fs : ForwardingSource = ForwardingSource(bufferedSink)
        //forwardingSink.isClosed()
        fs.read(Source,0)

        var exce = ""
        try{
        fs.timeout()
        }catch(e: Exception){
            exce = e.message
        }
        @Assert(exce , "" )
        
        var exc = ""
        try{
        fs.close()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc , "" )

        var exc1 = ""
        try{
        fs.delegate()
        }catch(e: Exception){
            exc1 = e.message
        }
        @Assert(exc1 , "" )
        
        println(fs.delegate())
        println(fs.toString())
        @Assert(fs.toString(),"Source([size=0] [])")
    
    }

    @TestCase 
    func okio_Pipe_fold_238_3(): Unit {

        println("---------------------------okio_Pipe_fold_238_2-----------------------------")
        let buffer = Buffer()
        let sink: Sink = buffer
        let bufferedSink: BufferedSink = Okio.buffer(sink)
        let byteString: ByteString = ByteString("hello world".toArray())
        bufferedSink.write(byteString)
        println(bufferedSink.toString())
        var exc = ""
        var pi: Pipe = Pipe(Int64.Max)
        pi.fold(bufferedSink)
        @Assert(pi.source() is Source ,true)
    }

    
}

