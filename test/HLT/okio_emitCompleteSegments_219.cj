// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_emitCompleteSegments_219{

    @TestCase //Segment 空值
    func okio_emitCompleteSegments_219(): Unit {
        var exc = ""
        try {
            remove("../../../testData/okio_emit_214.txt", recursive: true)
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        
        var file = File.create("../../../testData/okio_emit_214.txt")
        let bufferedSink: BufferedSink = Okio.buffer(Okio.sink(file))

        try {
            var byteString = ByteString("hello".toArray())
            byteString.write("../../../testData/okio_emit_214.txt")

            file = File("../../../testData/okio_emit_214.txt", OpenMode.Read)
            var reals = Okio.buffer(Okio.source(file))

            var size = bufferedSink.buffer().size
            println("bufferedSink size: ${size}")
            @Assert(size,0)

            var str = reals.readUtf8()
            println("sink : ${str}")
            @Assert(str,"hello")

            println("sink lenth : ${str.size}")
            @Assert(str.size,5)

            println("bufferedSink.emitCompleteSegments()")
            bufferedSink.emitCompleteSegments()

            var file2 = File("../../../testData/okio_emit_214.txt", OpenMode.Read)
            reals = Okio.buffer(Okio.source(file2))

            size = bufferedSink.buffer().size
            println("bufferedSink size: ${size}")
            @Assert(size,0)
            
            str = reals.readUtf8()
            
            println("sink lenth : ${str.size}")
            @Assert(str.size,5)

            println("sink : ${str}")
            @Assert(str,"hello")


        } catch (e:Exception) {
            println(e.message)
        }
    }

}