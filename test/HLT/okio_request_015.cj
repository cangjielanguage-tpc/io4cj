// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

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
    @TestCase
    func okio_request_015_2(): Unit {
        var exc = ""
        let a_buffer = Buffer()
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        try{
            println(bufferedSource.request(1))
            
        } catch(e: Exception) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(bufferedSource.request(1),false)
        @Assert(exc,"")
    }
}