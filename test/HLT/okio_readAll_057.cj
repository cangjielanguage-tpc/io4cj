// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_readAll_057{

    @TestCase
    func okio_readAll_057(): Unit {
        var exc = ""
        try {
            File.delete("../../../testData/okio_readAll_057.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }

        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        var file = File.create("../../../testData/okio_readAll_057.txt")
        let sink: Sink = Okio.sink(file)
        var num : Int64 = 0

        try {
            num = a_buffer.readAll(sink)
            sink.close()
            let bs = ByteString.read("../../../testData/okio_readAll_057.txt")
            println("bs = ${bs.toString()}")

        } catch (e:Exception) {
            println(e.message)
        }
        @Assert(num,9)
        // @Assert(bs.toString(),"[text=[6, 5, 4, 3, 2, 16, 7, 100, 9]]") //提单 issues/I5YUHR
    }
    @TestCase
    func okio_readAll_057_2(): Unit {
        var exc = ""
        try {
            File.delete("../../../testData/okio_readAll_057_2.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        var file = File.create("../../../testData/okio_readAll_057_2.txt")
        let sink: Sink = Okio.sink(file)
        var num : Int64 = 0

        try {
            num = bufferedSource.readAll(sink)
            sink.close()
            let bs = ByteString.read("../../../testData/okio_readAll_057_2.txt")
            println("bs = ${bs.toString()}")

        } catch (e:Exception) {
            println(e.message)
        }
        @Assert(num,9)
        // @Assert(bs.toString(),"[text=[6, 5, 4, 3, 2, 16, 7, 100, 9]]") //提单 issues/I5YUHR
    }
}