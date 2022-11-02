// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readString_064{

    @TestCase
    func okio_readString_064(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        @Assert(a_buffer.toString(),"[size=6] [91, 49, 44, 32, 50, 93]")
        @Assert(a_buffer.readString().getOrThrow(),arrb.toString())
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
}