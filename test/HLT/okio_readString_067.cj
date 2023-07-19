// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readString_067{

    @TestCase
    func okio_readString_067(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [1,2]
            let a_buffer = Buffer()
            a_buffer.writeUtf8(arrb.toString())
            println(a_buffer)
            println(a_buffer.readString(7))
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase
    func okio_readString_067_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [1,2]
            let a_buffer = Buffer()
            a_buffer.writeUtf8(arrb.toString())
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(a_buffer)
            println(bufferedSource.readString(7))
        } catch (e:EOFException) {
            //e.printStackTrace()
            println("e.message = EOFException")
            exc="EOFException"
        }
        @Assert(exc.contains("EOFException"),true)
    }
}