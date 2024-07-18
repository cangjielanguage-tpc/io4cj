// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import std.math.*
import io4cj.*

@Test
public class okio_Pipe_sink_236{

    @TestCase 
    // 获取sink对象。
    func okio_Pipe_sink_236(): Unit {

        println("---------------------------okio_Pipe_sink_236-----------------------------")
        var pi: Pipe = Pipe(1)
        pi.sink()
        @Assert(pi.sink() is Sink ,true)
    }
    @TestCase 
    func okio_Pipe_sink_236_2(): Unit {

        println("---------------------------okio_Pipe_sink_236_2-----------------------------")
        var pi: Pipe = Pipe(Int64.Max)
        pi.sink()
        @Assert(pi.sink() is Sink ,true)
    }
}