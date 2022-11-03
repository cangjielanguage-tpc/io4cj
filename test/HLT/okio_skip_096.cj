// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_skip_096{

    @TestCase
    func okio_skip_096(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.skip(8))
            println(a_buffer)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException:"),true)
    }   
}