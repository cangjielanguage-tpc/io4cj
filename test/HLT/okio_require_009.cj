// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_require_009{

    @TestCase //require(byteCount: Int64): Unit  byteCount = 1 异常
    func okio_require_009(): Unit {
        var exc = ""
        try{
            let a_buffer = Buffer()
            println(a_buffer.require(1))
        } catch(e: EOFException) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase //require(byteCount: Int64): Unit  byteCount = 1 异常
    func okio_require_009_2(): Unit {
        var exc = ""
        try{

            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.require(1))
        } catch(e: EOFException) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
}