// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_read_115{

    @TestCase
    func okio_read_115(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_read_115.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        try {
            var file = File.create("../../testData/okio_read_115.txt")
            file.write("hello world".toUtf8Array())
            let bs = ByteString.read("../../testData/okio_read_115.txt")
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")

            
            let bs2 = ByteString.read("../../testData/okio_read_115.txt")
            println("bs2 = ${bs2.toString()}")
            @Assert(bs2.toString(),"[text=hello world]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}