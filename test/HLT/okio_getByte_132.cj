// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getByte_132 {

    @TestCase
    func okio_getByte_132(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.getByte(12)}")
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            // println("e.message = ${e.message}")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc.contains("IndexOutOfBoundsException"),true)
    }   
}