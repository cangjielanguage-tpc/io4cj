// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_of_101{

    @TestCase
    func okio_of_101(): Unit {
        try {
            let bs = ByteString.of("hello world".toArray())
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")
            
            let bs2 = ByteString.of("".toArray())
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}