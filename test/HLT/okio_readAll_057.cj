// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_readAll_057{

    @TestCase
    func okio_readAll_057(): Unit {
        var exc = ""
        try {
            File.delete("../testData/okio_readAll_057.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        var file = File.create("../testData/okio_readAll_057.txt")
        let sink: Sink = Okio.sink(file)
        var num : Int64 = 0

        try {
            num = a_buffer.readAll(sink)
            sink.close()
            let bs = ByteString.read("../testData/okio_readAll_057.txt")
            println("bs = ${bs.toString()}")

        } catch (e:Exception) {
            println(e.message)
        }
        @Assert(num,9)
        // @Assert(bs.toString(),"[text=[6, 5, 4, 3, 2, 16, 7, 100, 9]]") //提单
    }
}