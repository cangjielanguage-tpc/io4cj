// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_readAll_058{

    @TestCase
    func okio_readAll_058(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_readAll_058.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        exc = ""
        try {
            let a_buffer = Buffer()
            var file = File.create("../../testData/okio_readAll_058.txt")
            let sink: Sink = Okio.sink(file)
            println(a_buffer)
            println(a_buffer.readAll(sink))
            sink.close()
            let bs = ByteString.read("../../testData/okio_readAll_058.txt")
        } catch (e:Exception) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
        @Assert(exc.contains("The buffer is empty."),true)
    }
    @TestCase
    func okio_readAll_058_2(): Unit {
        var exc = ""
        try {
            File.delete("../../testData/okio_readAll_058_2.txt")
        } catch (e:Exception){
            println("e.message = ${e.message}")
        }
        exc = ""
        try {
            let a_buffer = Buffer()
            var file = File.create("../../testData/okio_readAll_058_2.txt")
            let sink: Sink = Okio.sink(file)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readAll(sink))
            sink.close()
            let bs = ByteString.read("../../testData/okio_readAll_058_2.txt")
        } catch (e:Exception) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
        @Assert(exc.contains("The buffer is empty."),true)
    }
}