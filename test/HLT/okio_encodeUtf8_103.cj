// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_encodeUtf8_103{

    @TestCase
    func okio_encodeUtf8_103(): Unit {
        try {
            let bs = ByteString.encodeUtf8("hello world")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")
            
            let bs2 = ByteString.encodeUtf8("")
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}