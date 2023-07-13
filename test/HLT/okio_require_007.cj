// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_require_007{

    @TestCase //require(byteCount: Int64): Unit  byteCount = 0 
    func okio_require_007(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            println(a_buffer.require(0))
        } catch(e: EOFException) { 
            println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase //require(byteCount: Int64): Unit  byteCount = 0 
    func okio_require_007_2(): Unit {
        var exc = ""
        try{
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.require(0))
        } catch(e: EOFException) { 
            println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}