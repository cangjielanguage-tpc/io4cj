// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from std import math.*
from okio import okio.*

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