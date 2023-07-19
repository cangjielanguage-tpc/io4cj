// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_toAsciiLowercase_119 {

    @TestCase
    func okio_toAsciiLowercase_119(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.toAsciiLowercase()}")
            @Assert(bs.toAsciiLowercase().toString(),"[text=hello world]")

            let str2 = "HELLO WORLD"
            let arr2:Array<Byte> = str2.toUtf8Array()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${bs2.toAsciiLowercase()}")
            @Assert(bs2.toAsciiLowercase().toString(),"[text=hello world]")

            let str3 = ""
            let arr3:Array<Byte> = str3.toUtf8Array()
            println(arr3)
            let bs3 = ByteString(arr3)
            println("bs3 = ${bs3.toAsciiLowercase()}")
            @Assert(bs3.toAsciiLowercase().toString(),"[size=0]")

            let str4 = "1234567890"
            let arr4:Array<Byte> = str4.toUtf8Array()
            println(arr4)
            let bs4 = ByteString(arr4)
            println("bs4 = ${bs4.toAsciiLowercase()}")
            @Assert(bs4.toAsciiLowercase().toString(),"[text=1234567890]")

            let str5 = "hElLo WOrlD"
            let arr5:Array<Byte> = str5.toUtf8Array()
            println(arr5)
            let bs5 = ByteString(arr5)
            println("bs5 = ${bs5.toAsciiLowercase()}")
            @Assert(bs5.toAsciiLowercase().toString(),"[text=hello world]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}