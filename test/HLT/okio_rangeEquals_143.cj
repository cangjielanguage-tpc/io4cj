// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_rangeEquals_143 {

    @TestCase
    func okio_rangeEquals_143(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toArray())
            var byteString2 = ByteString("123hello world456".toArray())
            var tf = byteString.rangeEquals(-1,byteString2,3,1)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}