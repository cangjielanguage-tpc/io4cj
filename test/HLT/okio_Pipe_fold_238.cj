// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from std import math.*
from okio import okio.*

@Test
public class okio_Pipe_fold_238{

    @TestCase 
    // 将此管道的任何缓冲内容写入 sink，然后用 sink替换此管道的源。
    func okio_Pipe_fold_238(): Unit {

        println("---------------------------okio_Pipe_fold_238-----------------------------")
        var exc = ""
        var pi: Pipe = Pipe(1)
        pi.source()
        @Assert(pi.source() is Source ,true)
    }
    @TestCase 
    func okio_Pipe_fold_238_2(): Unit {

        println("---------------------------okio_Pipe_fold_238_2-----------------------------")
        var exc = ""
        var pi: Pipe = Pipe(Int64.Max)
        pi.sink()
        @Assert(pi.source() is Source ,true)
    }
}