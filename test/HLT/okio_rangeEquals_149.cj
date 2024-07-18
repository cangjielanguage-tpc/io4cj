// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_rangeEquals_149 {

    @TestCase
    func okio_rangeEquals_149(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toArray())
            var byteArray : Array<Byte> = "123hello world456".toArray()
            var tf = byteString.rangeEquals(5,byteArray,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)

            tf = byteString.rangeEquals(5,byteArray,3,12)
            println("true or false : ${tf}")
            @Assert(tf,false)

            tf = byteString.rangeEquals(0,byteArray,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "l".toArray()
            tf = byteString.rangeEquals(8,byteArray,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "h".toArray()
            tf = byteString.rangeEquals(8,byteArray,0,1)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteArray = "".toArray()
            tf = byteString.rangeEquals(1,byteArray,0,0)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "123hello world456789".toArray()
            tf = byteString.rangeEquals(5,byteArray,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)
            
            byteString = ByteString("".toArray())
            byteArray = "".toArray()
            tf = byteString.rangeEquals(0,byteArray,0,0)
            println("true or false : ${tf}")
            @Assert(tf,true)
        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}