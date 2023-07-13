// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_110{

    @TestCase
    func okio_read_110(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "".toUtf8Array()
            var bas = ByteArrayStream()
            bas.write(arr)

            let bs = ByteString.read(bas,0)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
    }   
}