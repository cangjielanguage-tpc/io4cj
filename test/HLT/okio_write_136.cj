// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_write_136{

    @TestCase
    func okio_write_136(): Unit {
        var exc = ""
        try {
            remove("../../../testData/okio_write_136.txt", recursive: true)
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        
        var str = "hello world"
        try {
            File.create("../../../testData/okio_write_136.txt")
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            bs.write("../../../testData/okio_write_136.txt")
            var bytearry = File.readFrom("../../../testData/okio_write_136.txt")
            str = String.fromUtf8(bytearry)

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(str,"hello world")
    }   
}