// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_substring_124 {

    @TestCase
    func okio_substring_124(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.substring(8,9)}")
            @Assert(bs.substring(8,9).toString(),"[text=r]") 
            
            let bs2 = ByteString(arr)
            println("bs2 = ${bs2.substring(0,11)}")
            @Assert(bs2.substring(0,11).toString(),"[text=hello world]")

            let bs4 = ByteString(arr)
            println("bs4 = ${bs4.substring(0,0)}")
            @Assert(bs4.substring(0,0).toString(),"[size=0]") 

            let str3 = ""
            let arr3:Array<Byte> = str3.toArray()
            println(arr3)
            let bs3 = ByteString(arr3)
            println("bs3 = ${bs3.substring(0,0)}")
            @Assert(bs3.substring(0,0).toString(),"[size=0]")


        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}