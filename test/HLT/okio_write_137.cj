// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_write_137{

    @TestCase
    func okio_write_137(): Unit {
        var exc = ""
        try {
            File.delete("../../../testData/okio_write_137.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        var str = "world"
        try {
            var file = File.create("../../../testData/okio_write_137.txt")
            file.write("hello ".toArray())
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            bs.write("../../../testData/okio_write_137.txt")

            var bytearry = File.readFrom("../../../testData/okio_write_137.txt")
            str = String.fromUtf8(bytearry)
            

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(str,"hello world")
    }   
}