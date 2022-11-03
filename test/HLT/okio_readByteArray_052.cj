// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readByteArray_052{

    @TestCase
    func okio_readByteArray_052(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readByteArray(10))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}