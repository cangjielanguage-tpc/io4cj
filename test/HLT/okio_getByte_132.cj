// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_getByte_132 {

    @TestCase
    func okio_getByte_132(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
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