// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_hex_107 {

    @TestCase
    func okio_hex_107(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.hex()}")
            @Assert(bs.hex(),"68656c6c6f20776f726c64")

            let str2 = ""
            let arr2:Array<Byte> = str2.toArray()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${bs2.hex()}")
            @Assert(bs2.hex(),"")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}