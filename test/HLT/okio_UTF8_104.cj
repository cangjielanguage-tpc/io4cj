// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_UTF8_104{

    @TestCase
    func okio_UTF8_104(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.UTF8()}")
            @Assert(bs.UTF8(),"hello world")

            let str2 = ""
            let arr2:Array<Byte> = str2.toUtf8Array()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${bs2.UTF8()}")
            @Assert(bs2.UTF8(),"")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}