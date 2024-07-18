// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_substring_121 {

    @TestCase
    func okio_substring_121(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.substring(0)}")
            @Assert(bs.substring(0).toString(),"[text=hello world]")

            let bs2 = ByteString(arr)
            println("bs2 = ${bs2.substring(11)}")
            @Assert(bs2.substring(11).toString(),"[size=0]")

            let bs4 = ByteString(arr)
            println("bs4 = ${bs4.substring(10)}")
            @Assert(bs4.substring(10).toString(),"[text=d]")

            let str3 = ""
            let arr3:Array<Byte> = str3.toArray()
            println(arr3)
            let bs3 = ByteString(arr3)
            println("bs3 = ${bs3.substring(0)}")
            @Assert(bs3.substring(0).toString(),"[size=0]")


        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}