// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_092{

    @TestCase
    func okio_indexOf_092(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.indexOf(16,1,10))
            @Assert(a_buffer.indexOf(16,1,10),5)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        // @Assert(exc.contains("fromIndex: 1 is greater than toIndex: 1 or less than 0"),true)
    }   
}