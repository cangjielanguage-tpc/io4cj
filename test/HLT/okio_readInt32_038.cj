// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readInt32_038{

    @TestCase
    func okio_readInt32_038(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readInt32())
            //println(Int16((6<<8) | 5))
            println(a_buffer)
            println(a_buffer.size)
            println(a_buffer.exhausted())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 4: 3")
    }
    @TestCase
    func okio_readInt32_038_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.readInt32())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}