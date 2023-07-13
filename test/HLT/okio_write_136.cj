// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_write_136{

    @TestCase
    func okio_write_136(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_write_136.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        
        var str = "hello world"
        try {
            File.create("../../testData/okio_write_136.txt")
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            bs.write("../../testData/okio_write_136.txt")
            var bytearry = File.readFrom("../../testData/okio_write_136.txt")
            str = String.fromUtf8(bytearry)

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(str,"hello world")
    }   
}