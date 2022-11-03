// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_request_013{

    @TestCase
    func okio_request_013(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            println(a_buffer.request(0)) 
            @Assert(a_buffer.request(0),true)
        } catch(e: Exception) {//okio.EOFException 不是public
            println("Exception")
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}