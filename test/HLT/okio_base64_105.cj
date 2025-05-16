// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_base64_105{

    @TestCase
    func okio_base64_105(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.base64()}")
            @Assert(bs.base64(),"aGVsbG8gd29ybGQ=")

            let str2 = ""
            let arr2:Array<Byte> = str2.toArray()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${bs2.base64()}")
            @Assert(bs2.base64(),"")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}