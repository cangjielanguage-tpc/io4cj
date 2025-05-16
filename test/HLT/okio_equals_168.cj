// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_equals_168 {

    @TestCase
    func okio_equals_168 (): Unit {
        try {
            let bs = ByteString("hello world".toArray())
            let bs2 = ByteString("hello world".toArray())
            println("bs.equals(bs2) : ${bs.equals(bs2)}")
            @Assert(bs.equals(bs2),true)

            let bs3 = bs2
            println("bs3.equals(bs2) : ${bs3.equals(bs2)}")
            @Assert(bs3.equals(bs2),true)

            let bs4 = ByteString("".toArray())
            let bs5 = ByteString("".toArray())
            println("bs4.equals(bs5) : ${bs4.equals(bs5)}")
            @Assert(bs4.equals(bs5),true)

            let bs6 = ByteString("213".toArray())
            let bs7 = ByteString("456".toArray())
            println("bs6.equals(bs7) : ${bs6.equals(bs7)}")
            @Assert(bs6.equals(bs7),false)

            let bs8 = ByteString.of("hello world".toArray())
            println("bs8.equals(bs2) : ${bs8.equals(bs2)}")
            @Assert(bs8.equals(bs2),true)

            let bs9 = ByteString("213".toArray())
            let bs10 = ByteString("".toArray())
            println("bs10.equals(bs9) : ${bs10.equals(bs9)}")
            @Assert(bs10.equals(bs9),false)
            

        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}