// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_rangeEquals_142 {

    @TestCase
    func okio_rangeEquals_142(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toArray())
            var byteString2 = ByteString("123hello world456".toArray())
            var tf = byteString.rangeEquals(5,byteString2,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)

            tf = byteString.rangeEquals(5,byteString2,3,12)
            println("true or false : ${tf}")
            @Assert(tf,false)

            tf = byteString.rangeEquals(0,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("l".toArray())
            tf = byteString.rangeEquals(8,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("h".toArray())
            tf = byteString.rangeEquals(8,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteString2 = ByteString("".toArray())
            tf = byteString.rangeEquals(1,byteString2,0,0)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("123hello world456789".toArray())
            tf = byteString.rangeEquals(5,byteString2,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)
            
            byteString = ByteString("".toArray())
            byteString2 = ByteString("".toArray())
            tf = byteString.rangeEquals(0,byteString2,0,0)
            println("true or false : ${tf}")
            @Assert(tf,true)
        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}