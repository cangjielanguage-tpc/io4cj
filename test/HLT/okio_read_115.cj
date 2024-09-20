// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_read_115{

    @TestCase
    func okio_read_115(): Unit {
        var exc = ""
        try {
            remove("../../../testData/okio_read_115.txt", recursive: true)
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        try {
            var file = File.create("../../../testData/okio_read_115.txt")
            file.write("hello world".toArray())
            let bs = ByteString.read("../../../testData/okio_read_115.txt")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")

            
            let bs2 = ByteString.read("../../../testData/okio_read_115.txt")
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[text=hello world]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}