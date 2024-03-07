// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_Equatable_171 {

    @TestCase
    func okio_Equatable_171 (): Unit {
        try {
            let bs = ByteString("hello world".toArray())
            let bs2 = ByteString("hello world".toArray())
            println("bs == bs2 : ${bs == bs2}")
            println("bs != bs2 : ${bs != bs2}")
            @Assert(bs == bs2,true)
            @Assert(bs != bs2,false)

            let bs3 = bs2
            println("bs3 == bs2 : ${bs3 == bs2}")
            println("bs3 != bs2 : ${bs3 != bs2}")
            @Assert(bs3 == bs2,true)
            @Assert(bs3 != bs2,false)

            let bs4 = ByteString("".toArray())
            let bs5 = ByteString("".toArray())
            println("bs4 == bs5 : ${bs4 == bs5}")
            println("bs4 != bs5 : ${bs4 != bs5}")
            @Assert(bs4 == bs5,true)
            @Assert(bs4 != bs5,false)

            let bs6 = ByteString("213".toArray())
            let bs7 = ByteString("456".toArray())
            println("bs6 == bs7 : ${bs6 == bs7}")
            println("bs6 != bs7 : ${bs6 != bs7}")
            @Assert(bs6 == bs7,false)
            @Assert(bs6 != bs7,true)

            let bs8 = ByteString.of("hello world".toArray())
            println("bs8 == bs2 : ${bs8 == bs2}")
            println("bs8 != bs2 : ${bs8 != bs2}")
            @Assert(bs8 == bs2,true)
            @Assert(bs8 != bs2,false)

            let bs9 = ByteString("213".toArray())
            let bs10 = ByteString("".toArray())
            println("bs9 == bs10 : ${bs9 == bs10}")
            println("bs9 != bs10 : ${bs9 != bs10}")
            @Assert(bs9 == bs10,false)
            @Assert(bs9 != bs10,true)

        } catch (e:Exception) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}