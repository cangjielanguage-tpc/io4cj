// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getByte_133 {

    @TestCase
    func okio_getByte_133(): Unit {
        var exc = ""
        try {
            let str = ""
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.getByte(0)}")
        } catch (e:Exception) {
            // e.printStackTrace()
            // println("e.message = ${e.message}")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc.contains("IndexOutOfBoundsException"),true)
    }   
}