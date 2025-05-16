// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_rangeEquals_144 {

    @TestCase
    func okio_rangeEquals_144(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toArray())
            var byteString2 = ByteString("123hello world456".toArray())
            var tf = byteString.rangeEquals(-1,byteString2,-1,1)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}