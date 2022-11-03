// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt32_038{

    @TestCase
    func okio_readInt32_038(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readInt32())
            //println(Int16((6<<8) | 5))
            println(a_buffer)
            println(a_buffer.size)
            println(a_buffer.exhausted())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 4: 3")
    }
}