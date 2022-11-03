// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_toString_170 {

    @TestCase
    func okio_toString_170 (): Unit {
        try {
            let bs = ByteString("".toUtf8Array())
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")
            
            let bs2 = ByteString("hello world".toUtf8Array())
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[text=hello world]")

            let bs3 = ByteString("你好".toUtf8Array())
            println("bs3 = ${bs3.toString()}")
            @Assert(bs3.toString(),"[text=你好]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}