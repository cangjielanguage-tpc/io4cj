// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_read_117{

    @TestCase
    func okio_read_117(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_read_117.txt")
        } catch (e:Exception){
            // println("e.message = ${e.message}")
        }
        var bs : ByteString
        var bs2 : ByteString
        try {
            bs = ByteString.read("../../testData/okio_read_117.txt")
            println("bs = ${bs.toString()}")

            bs2 = ByteString.read("../../testData/okio_read_117_1.txt")
            println("bs2 = ${bs2.toString()}")
            

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("The file does not exist"),true)
    }   
}