// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_decodeHex_108{

    @TestCase
    func okio_decodeHex_108(): Unit {
        var exc = ""
        try {
            let bs = ByteString.decodeHex("68656c6c6f20776f726c64")
            println("bs = ${bs.toString()}")
            // @Assert(bs.toString(),"[text=hello world]")

            let bs3 = ByteString.decodeHex("68656c6c6f20776f726c6")

        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
        @Assert(exc.contains("Unexpected hex string: 68656c6c6f20776f726c6"),true)

        let bs2 = ByteString.decodeHex("")
        println("bs2 = ${bs2.toString()}")
        @Assert(bs2.toString(),"[size=0]")
    }   
}