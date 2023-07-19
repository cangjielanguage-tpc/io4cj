// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_require_008{

    @TestCase //require(byteCount: Int64): Unit  byteCount = -1 异常
    func okio_require_008(): Unit {
        var exc = ""
        try{
            let a_buffer = Buffer()
            // a_buffer.write(arrb)
            println(a_buffer.require(-1))
        } catch(e: Exception) { //okio.EOFException 不是public
            println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase //require(byteCount: Int64): Unit  byteCount = -1 异常
    func okio_require_008_2(): Unit {
        var exc = ""
        try{
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            // a_buffer.write(arrb)
            println(bufferedSource.require(-1))
        } catch(e: Exception) { //okio.EOFException 不是public
            // println(e.printStackTrace())
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"byteCount <0: -1")
    }
}