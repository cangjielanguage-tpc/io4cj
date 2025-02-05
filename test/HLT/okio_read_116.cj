// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_read_116{

    @TestCase
    func okio_read_116(): Unit {
        var exc = ""
        try {
            remove("../../../testData/okio_read_116.txt", recursive: true)
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        try {
            var file = File.create("../../../testData/okio_read_116.txt")
            let bs = ByteString.read("../../../testData/okio_read_116.txt")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")

            let bs2 = ByteString.read("../../../testData/okio_read_116.txt")
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("EOFException"),true)
    }   
}