// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readByteArray_049{

    @TestCase
    func okio_readByteArray_049(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(a_buffer.readByteArray(),arrb)
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readByteArray_049_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readByteArray(),arrb)
        @Assert(bufferedSource.exhausted(),true)

    }
}