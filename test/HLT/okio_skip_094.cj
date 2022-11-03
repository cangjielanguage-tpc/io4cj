// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_skip_094{

    @TestCase
    func okio_skip_094(): Unit {
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
            println(a_buffer.skip(-1))
            println(a_buffer)
            @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}