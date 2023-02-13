// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_toAsciiUppercase_120 {

    @TestCase
    func okio_toAsciiUppercase_120(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.toAsciiUppercase()}")
            @Assert(bs.toAsciiUppercase().toString(),"[text=HELLO WORLD]")

            let str2 = "HELLO WORLD"
            let arr2:Array<Byte> = str2.toUtf8Array()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${bs2.toAsciiUppercase()}")
            @Assert(bs2.toAsciiUppercase().toString(),"[text=HELLO WORLD]")

            let str3 = ""
            let arr3:Array<Byte> = str3.toUtf8Array()
            println(arr3)
            let bs3 = ByteString(arr3)
            println("bs3 = ${bs3.toAsciiUppercase()}")
            @Assert(bs3.toAsciiUppercase().toString(),"[size=0]")

            let str4 = "1234567890"
            let arr4:Array<Byte> = str4.toUtf8Array()
            println(arr4)
            let bs4 = ByteString(arr4)
            println("bs4 = ${bs4.toAsciiUppercase()}")
            @Assert(bs4.toAsciiUppercase().toString(),"[text=1234567890]")

            let str5 = "hElLo WOrlD"
            let arr5:Array<Byte> = str5.toUtf8Array()
            println(arr5)
            let bs5 = ByteString(arr5)
            println("bs5 = ${bs5.toAsciiUppercase()}")
            @Assert(bs5.toAsciiUppercase().toString(),"[text=HELLO WORLD]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}