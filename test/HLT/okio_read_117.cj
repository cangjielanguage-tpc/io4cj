// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_read_117{

    @TestCase
    func okio_read_117(): Unit {
        var exc = ""
        try {
            remove("../../../testData/okio_read_117.txt", recursive: true)
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        var bs : ByteString
        var bs2 : ByteString
        try {
            bs = ByteString.read("../../../testData/okio_read_117.txt")
            println("bs = ${bs.toString()}")

            bs2 = ByteString.read("../../../testData/okio_read_117_1.txt")
            println("bs2 = ${bs2.toString()}")
            

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("The file does not exist"),true)
    }   
}