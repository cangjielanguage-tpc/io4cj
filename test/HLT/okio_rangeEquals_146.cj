// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_rangeEquals_146 {

    @TestCase
    func okio_rangeEquals_146(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("hello worl".toArray())
            var tf = byteString.rangeEquals(0,byteString2,0,11)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}