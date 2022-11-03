// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt64Le_047{

    @TestCase
    func okio_readInt64Le_047(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.readInt64Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 8: 7")
    }
}