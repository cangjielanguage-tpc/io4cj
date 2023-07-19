// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readInt8_030{

    @TestCase
    func okio_readInt8_030(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readInt8())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
    @Assert(exc.contains("size == 0"),true)
    }
    @TestCase
    func okio_readInt8_030_2(): Unit {
        println("---------------------------------------------------------------")
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readInt8())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
    @Assert(exc.contains("EOFException"),true)
    }
}