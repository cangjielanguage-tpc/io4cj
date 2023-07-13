// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_089{

    @TestCase
    func okio_indexOf_089(): Unit {
        let arrb:Array<Byte> = [6,0,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        println(a_buffer.indexOf(0,2,7))
        @Assert(a_buffer.indexOf(0,2,7),-1)
    }
    @TestCase
    func okio_indexOf_089_2(): Unit {
        let arrb:Array<Byte> = [6,0,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(bufferedSource.indexOf(0,2,7))
        @Assert(bufferedSource.indexOf(0,2,7),-1)
    }
}   