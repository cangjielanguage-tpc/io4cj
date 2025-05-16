// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_Hashable_169 {

    @TestCase
    func okio_Hashable_169 (): Unit {
        try {
            let bs = ByteString("".toArray())
            println("bs = ${bs.hashCode()}")
            @Assert(bs.hashCode(),1)
            
            let bs2 = ByteString("hello world".toArray())
            println("bs2 = ${bs2.hashCode()}")
            @Assert(bs2.hashCode(),1923188771)

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}