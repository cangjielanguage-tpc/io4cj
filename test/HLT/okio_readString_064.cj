// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readString_064{

    @TestCase
    func okio_readString_064(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        @Assert(a_buffer.toString(),"[size=6] [91, 49, 44, 32, 50, 93]")
        @Assert(a_buffer.readString(),arrb.toString())
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readString_064_2(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(bufferedSource)
        @Assert(bufferedSource.readString(),arrb.toString())
        @Assert(bufferedSource.exhausted(),true)

    }
}