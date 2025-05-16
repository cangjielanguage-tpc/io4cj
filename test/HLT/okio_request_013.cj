// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

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
        } catch(e: Exception) {//EOFException 不是public
            println("Exception")
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase
    func okio_request_013_(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(0)) 
            @Assert(bufferedSource.request(0),true)
        } catch(e: Exception) {//EOFException 不是public
            println("Exception")
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}