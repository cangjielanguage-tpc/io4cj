// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from std import math.*
from io4cj import okio.*

@Test
public class okio_Pipe_source_237{

    @TestCase 
    // 获取source对象。
    func okio_Pipe_source_237(): Unit {

        println("---------------------------okio_Pipe_source_237-----------------------------")
        var exc = ""
        var pi: Pipe = Pipe(1)
        pi.source()
        @Assert(pi.source() is Source ,true)
    }
    @TestCase 
    func okio_Pipe_source_237_2(): Unit {

        println("---------------------------okio_Pipe_source_237_2-----------------------------")
        var exc = ""
        var pi: Pipe = Pipe(Int64.Max)
        pi.sink()
        @Assert(pi.source() is Source ,true)
    }
}