// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16Le_034{

    @TestCase
    func okio_readInt16Le_034(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt16Le(),Int16((5<<8) | 6))
        @Assert(a_buffer.size,5)
        @Assert(a_buffer.exhausted(),false)
    }
}