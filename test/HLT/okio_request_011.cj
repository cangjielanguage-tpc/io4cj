// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_request_011{

    @TestCase
    func okio_request_011(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.request(7))
            @Assert(a_buffer.request(7),true)  
        } catch(e: Exception) {
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase
    func okio_request_011_2(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.request(7))
            @Assert(bufferedSource.request(7),true)  
        } catch(e: Exception) {
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}