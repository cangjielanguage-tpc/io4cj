// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_emit_215{

    @TestCase //Segment 空值
    func okio_emit_215(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_emit_214.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        
        var file = File.create("../../testData/okio_emit_214.txt")
        let bufferedSink: BufferedSink = Okio.buffer(Okio.sink(file))

        try {
            var byteString = ByteString("hello".toUtf8Array())
            byteString.write("../../testData/okio_emit_214.txt")

            file = File.openRead("../../testData/okio_emit_214.txt")
            var reals = Okio.buffer(Okio.source(file))

            var size = bufferedSink.buffer().size
            println("bufferedSink size: ${size}")
            @Assert(size,0)

            var str = reals.readUtf8()
            println("sink : ${str}")
            @Assert(str,"hello")

            println("sink lenth : ${str.size}")
            @Assert(str.size,5)

            println("bufferedSink.emit()")
            bufferedSink.emit()

            var file2 = File.openRead("../../testData/okio_emit_214.txt")
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