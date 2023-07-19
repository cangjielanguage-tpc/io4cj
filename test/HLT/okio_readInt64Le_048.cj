// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readInt64Le_048{

    @TestCase
    func okio_readInt64Le_048(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readInt64Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 8: 0")
    }
    @TestCase
    func okio_readInt64Le_048_2(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readInt64Le())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}