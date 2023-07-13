// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getByte_131 {

    @TestCase
    func okio_getByte_131(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.getByte(11)}")
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }   
}