// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt32Le_041{

    @TestCase
    func okio_readInt32Le_041(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.readInt32Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 4: 3")
    }
}