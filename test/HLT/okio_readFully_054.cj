// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readFully_054{

    @TestCase
    func okio_readFully_054(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2:Array<Byte> = Array<Byte>(10,item:0)
            println(a_buffer)
            println(a_buffer.readFully(arrb2))
        } catch (e:EOFException) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
    }
}