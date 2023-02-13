// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_rangeEquals_142 {

    @TestCase
    func okio_rangeEquals_142(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toUtf8Array())
            var byteString2 = ByteString("123hello world456".toUtf8Array())
            var tf = byteString.rangeEquals(5,byteString2,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)

            tf = byteString.rangeEquals(5,byteString2,3,12)
            println("true or false : ${tf}")
            @Assert(tf,false)

            tf = byteString.rangeEquals(0,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("l".toUtf8Array())
            tf = byteString.rangeEquals(8,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("h".toUtf8Array())
            tf = byteString.rangeEquals(8,byteString2,0,1)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteString2 = ByteString("".toUtf8Array())
            tf = byteString.rangeEquals(1,byteString2,0,0)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("123hello world456789".toUtf8Array())
            tf = byteString.rangeEquals(5,byteString2,3,11)
            println("true or false : ${tf}")
            @Assert(tf,true)
            
            byteString = ByteString("".toUtf8Array())
            byteString2 = ByteString("".toUtf8Array())
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