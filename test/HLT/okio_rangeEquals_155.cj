// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_rangeEquals_155 {

    @TestCase
    func okio_rangeEquals_155(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "hello world".toArray()
            var tf = byteString.rangeEquals(1,byteArray,1,11)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}