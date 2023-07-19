// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

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
    @TestCase
    func okio_request_010_2(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(8)) 
            @Assert(bufferedSource.request(8),false)  
        } catch(e: Exception) {//okio.EOFException 不是public
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")

        exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)  
            bufferedSource.close()  
            bufferedSource.request(8)
        } catch (e:IllegalArgumentException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"closed")
    }
}