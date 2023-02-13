// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8_063{

    @TestCase
    func okio_readUtf8_063(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readUtf8(1))
            println(a_buffer)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase
    func okio_readUtf8_063_2(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readUtf8(1))
            println(bufferedSource)
        } catch (e:EOFException) {
            //e.printStackTrace()
            println("e.message = EOFException")
            exc="EOFException"
        }
        @Assert(exc.contains("EOFException"),true)
    }
}