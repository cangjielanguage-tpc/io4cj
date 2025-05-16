// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_UTF8_104{

    @TestCase
    func okio_UTF8_104(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.UTF8()}")
            @Assert(bs.UTF8(),"hello world")

            let str2 = ""
            let arr2:Array<Byte> = str2.toArray()
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