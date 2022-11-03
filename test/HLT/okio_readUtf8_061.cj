// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8_061{

    @TestCase
    func okio_readUtf8_061(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        @Assert(a_buffer.toString(),"[size=6] [91, 49, 44, 32, 50, 93]")
        @Assert(a_buffer.readUtf8(3).getOrThrow(),"[1,")
        @Assert(a_buffer.size,3)
        @Assert(a_buffer.exhausted(),false)
    }
}