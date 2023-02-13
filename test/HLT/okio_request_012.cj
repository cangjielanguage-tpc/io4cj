// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_request_012{

    @TestCase
    func okio_request_012(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.request(6))
            @Assert(a_buffer.request(6),true)
        } catch(e: Exception) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase
    func okio_request_012_2(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(6))
            @Assert(bufferedSource.request(6),true)
        } catch(e: Exception) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}