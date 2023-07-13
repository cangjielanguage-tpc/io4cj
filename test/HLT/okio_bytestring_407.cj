// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from std import fs.*

@Test
public class okio_byteString_407 {

    @TestCase 
    func okio_byteString_write_221(): Unit {

        println("---------------------------okio_byteString_write_221-----------------------------")

        var file = File("../../testData/okio_emitCompleteSegments_214.txt" , CreateOrTruncate(true))
        let bufferedSink: BufferedSink = Okio.buffer(Okio.sink(file))

        try {
            var byteString = ByteString("hello".toUtf8Array())
            byteString.write(file)
            var i = 0
            while(i < 8193){
                i++;
                bufferedSink.buffer().writeUtf8(i.toString()) 
            }
            
            file = File.openRead("../../testData/okio_emitCompleteSegments_214.txt")
            var reals = Okio.buffer(Okio.source(file))

            var size = bufferedSink.buffer().size
            println("bufferedSink size: ${size}")
            @Assert(size,31665)
        }catch (e:Exception) {
            println(e.message)
        }
    } 

    @TestCase 
    func okio_byteString_write_222(): Unit {

        println("---------------------------okio_byteString_write_222-----------------------------")

        let buffer: Buffer = Buffer()
        try {
            var byteString = ByteString("hello".toUtf8Array())
            byteString.write(buffer)
            

            var size = buffer.size
            println("bufferedSink size: ${size}")
            @Assert(size,5)
        }catch (e:Exception) {
            println(e.message)
        }
    } 

}
