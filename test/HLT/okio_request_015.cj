// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_request_015{

    @TestCase
    func okio_request_015(): Unit {
        var exc = ""
        let a_buffer = Buffer()
        try{
            println(a_buffer.request(1))
            
        } catch(e: Exception) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(a_buffer.request(1),false)
        @Assert(exc,"")
    }
}