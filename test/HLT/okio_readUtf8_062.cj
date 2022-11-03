// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8_062{

    @TestCase
    func okio_readUtf8_062(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [1,2]
            let a_buffer = Buffer()
            a_buffer.writeUtf8(arrb.toString())
            println(a_buffer)
            println(a_buffer.readUtf8(7).getOrThrow())
            println(a_buffer)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}