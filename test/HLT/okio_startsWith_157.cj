// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_startsWith_157 {

    @TestCase
    func okio_startsWith_157(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "".toArray()
            var tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "h".toArray()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hel".toArray()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hello world".toArray()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "rld".toArray()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteArray = " ".toArray()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}