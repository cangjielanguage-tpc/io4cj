// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_rangeEquals_151 {

    @TestCase
    func okio_rangeEquals_151(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("12345hello world6".toUtf8Array())
            var byteArray : Array<Byte> = "123hello world456".toUtf8Array()
            var tf = byteString.rangeEquals(-1,byteArray,-1,1)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}