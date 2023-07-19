// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_indexOf_080{

    @TestCase
    func okio_indexOf_080(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.indexOf(5),1)
    }
    @TestCase
    func okio_indexOf_080_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.indexOf(5),1)

        var exc = ""
        try{
            bufferedSource.close()
            bufferedSource.indexOf(5)
        } catch (e:Exception) {
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc.contains("closed"),true)
    }
}