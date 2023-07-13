// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readByteArray_052{

    @TestCase
    func okio_readByteArray_052(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readByteArray(10))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase
    func okio_readByteArray_052_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readByteArray(10))
        } catch (e:EOFException) {
            println("EOFException")
            exc="EOFException"
        }
        @Assert(exc.contains("EOFException"),true)
    }
}