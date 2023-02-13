// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_025{

    @TestCase
    func okio_read_025(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
            println(a_buffer.read(arrb2,5,-1))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
    @TestCase
    func okio_read_025_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.read(arrb2,5,-1))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
}