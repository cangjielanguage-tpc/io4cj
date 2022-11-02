// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_request_010{

    @TestCase
    func okio_request_010(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.request(8)) 
            @Assert(a_buffer.request(8),false)  
        } catch(e: Exception) {//okio.EOFException 不是public
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}