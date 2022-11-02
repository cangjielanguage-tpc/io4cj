// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt8_030{

    @TestCase
    func okio_readInt8_030(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readInt8())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
    @Assert(exc.contains("size == 0"),true)
    }
}