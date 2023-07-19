// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

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