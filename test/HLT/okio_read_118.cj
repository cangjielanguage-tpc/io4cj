// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_read_118{

    @TestCase
    func okio_read_118(): Unit {
        var exc = ""
        try {
            let bs = ByteString.read("../aaa/testData3.txt")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("does not exist"),true)
    }   
}