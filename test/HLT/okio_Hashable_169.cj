// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_Hashable_169 {

    @TestCase
    func okio_Hashable_169 (): Unit {
        try {
            let bs = ByteString("".toUtf8Array())
            println("bs = ${bs.hashCode()}")
            @Assert(bs.hashCode(),1)
            
            let bs2 = ByteString("hello world".toUtf8Array())
            println("bs2 = ${bs2.hashCode()}")
            @Assert(bs2.hashCode(),1923188771)

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}