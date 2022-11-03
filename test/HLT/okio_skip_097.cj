// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_skip_097{

    @TestCase
    func okio_skip_097(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.skip(1))
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException:"),true)
    }   
}