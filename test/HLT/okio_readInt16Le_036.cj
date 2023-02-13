// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16Le_036{

    @TestCase
    func okio_readInt16Le_036(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            println(a_buffer.readInt16Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 0")
    }
    @TestCase
    func okio_readInt16Le_036_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.readInt16Le())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}