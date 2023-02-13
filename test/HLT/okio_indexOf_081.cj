// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_081{

    @TestCase
    func okio_indexOf_081(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        println(a_buffer.indexOf(4))
        @Assert(a_buffer.indexOf(4),2)
    }
    @TestCase
    func okio_indexOf_081_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,7]
        let a_buffer = Buffer()
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        a_buffer.write(arrb)
        println(bufferedSource.indexOf(4))
        @Assert(bufferedSource.indexOf(4),2)
    }
}