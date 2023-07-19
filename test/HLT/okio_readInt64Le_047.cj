// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readInt64Le_047{

    @TestCase
    func okio_readInt64Le_047(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.readInt64Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 8: 7")
    }
    @TestCase
    func okio_readInt64Le_047_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.readInt64Le())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}