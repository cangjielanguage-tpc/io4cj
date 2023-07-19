// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readUtf8_059{

    @TestCase
    func okio_readUtf8_059(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        @Assert(a_buffer.toString(),"[size=6] [91, 49, 44, 32, 50, 93]")
        @Assert(a_buffer.readUtf8(),arrb.toString())
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readUtf8_059_2(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8(),arrb.toString())
        @Assert(bufferedSource.exhausted(),true)

    }
}