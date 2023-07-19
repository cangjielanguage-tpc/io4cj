// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_decodeBase64_106{

    @TestCase
    func okio_decodeBase64_106(): Unit {
        try {
            let bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"Some([text=hello world])")

            let bs2 = ByteString.decodeBase64("")
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"Some([size=0])")

            let bs3 = ByteString.decodeBase64("aGVsbG8gd29ybG")
            println("bs3 = ${bs3.toString()}")
            @Assert(bs3.toString(),"Some([text=hello worl])")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}