// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_020{

    @TestCase
    func okio_read_020(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
            a_buffer.read(arrb2,7,1)
        } catch (e:ArrayIndexOutOfBoundsException) {
            println("[${e.message}]")
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
    @TestCase
    func okio_read_020_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            bufferedSource.read(arrb2,7,1)
        } catch (e:ArrayIndexOutOfBoundsException) {
            println("[${e.message}]")
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
}