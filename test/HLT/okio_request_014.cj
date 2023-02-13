// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_request_014{

    @TestCase
    func okio_request_014(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            println(a_buffer.request(-1))
            @Assert(a_buffer.request(-1),true)  
        } catch(e: Exception) {
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase
    func okio_request_014_2(): Unit {
        var exc = ""
        try{
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(-1))
            @Assert(bufferedSource.request(-1),true)  
        } catch(e: Exception) {
            // println(e.printStackTrace())
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"byteCount <0: -1")
    }
}