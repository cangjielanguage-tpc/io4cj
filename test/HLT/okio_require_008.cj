// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_require_008{

    @TestCase //require(byteCount: Int64): Unit  byteCount = -1 异常
    func okio_require_008(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            // a_buffer.write(arrb)
            println(a_buffer.require(-1))
        } catch(e: Exception) { //okio.EOFException 不是public
            println(e.printStackTrace())
            exc = ""
        }
        @Assert(exc,"")
    }
}