// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16Le_036{

    @TestCase
    func okio_readInt16Le_036(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            println(a_buffer.readInt16Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 0")
    }
}