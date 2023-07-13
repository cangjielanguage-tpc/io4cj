// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

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