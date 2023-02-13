// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16Le_035{

    @TestCase
    func okio_readInt16Le_035(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.readInt16Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 1")
    }
    @TestCase
    func okio_readInt16Le_035_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
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