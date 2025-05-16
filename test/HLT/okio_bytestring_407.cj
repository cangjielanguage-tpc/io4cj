// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*
import std.fs.*

@Test
public class okio_byteString_407 {

    @TestCase 
    func okio_byteString_write_221(): Unit {

        println("---------------------------okio_byteString_write_221-----------------------------")
        let path: Path = Path("../../../testData/okio_emitCompleteSegments_214.txt")
        if (exists(path)) {
            remove(path, recursive: true)
        }
        var file = File(path , OpenMode.ReadWrite)
        let bufferedSink: BufferedSink = Okio.buffer(Okio.sink(file))

        try {
            var byteString = ByteString("hello".toArray())
            byteString.write(file)
            var i = 0
            while(i < 8193){
                i++;
                bufferedSink.buffer().writeUtf8(i.toString()) 
            }
            
            file = File("../../../testData/okio_emitCompleteSegments_214.txt", OpenMode.Read)
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
            var byteString = ByteString("hello".toArray())
            byteString.write(buffer)
            

            var size = buffer.size
            println("bufferedSink size: ${size}")
            @Assert(size,5)
        }catch (e:Exception) {
            println(e.message)
        }
    } 

}
