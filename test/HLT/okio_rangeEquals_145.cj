// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_rangeEquals_145 {

    @TestCase
    func okio_rangeEquals_145(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello worl".toUtf8Array())
            var byteString2 = ByteString("hello world".toUtf8Array())
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