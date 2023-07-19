// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readInt32_039{

    @TestCase
    func okio_readInt32_039(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readInt32())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 4: 0")
    }
    @TestCase
    func okio_readInt32_039_2(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(a_buffer)
            println(bufferedSource.readInt32())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}