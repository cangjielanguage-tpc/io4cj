// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16_032{

    @TestCase
    func okio_readInt16_032(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readInt16())
            println(a_buffer)
            println(a_buffer.size)
            println(a_buffer.exhausted())
        } catch (e:IllegalArgumentException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 0")
    }
}