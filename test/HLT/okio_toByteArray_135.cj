// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_toByteArray_135 {

    @TestCase
    func okio_toByteArray_135(): Unit {
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${String.fromUtf8(bs.toByteArray())}")
            @Assert(String.fromUtf8(bs.toByteArray()),"hello world")

            let str2 = ""
            let arr2:Array<Byte> = str2.toUtf8Array()
            println(arr2)
            let bs2 = ByteString(arr2)
            println("bs2 = ${String.fromUtf8(bs2.toByteArray())}")
            @Assert(String.fromUtf8(bs2.toByteArray()),"")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
        }
    }   
}