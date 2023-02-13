// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_rangeEquals_154 {

    @TestCase
    func okio_rangeEquals_154(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "hello world".toUtf8Array()
            var tf = byteString.rangeEquals(11,byteArray,11,1)
            println("true or false : ${tf}")
            @Assert(tf,false)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}