// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

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