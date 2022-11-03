// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_of_101{

    @TestCase
    func okio_of_101(): Unit {
        try {
            let bs = ByteString.of("hello world".toUtf8Array())
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")
            
            let bs2 = ByteString.of("".toUtf8Array())
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}