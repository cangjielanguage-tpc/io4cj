// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16_031{

    @TestCase
    func okio_readInt16_031(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt16(),Int16((6<<8) | 5))
        @Assert(a_buffer.size,5)
        @Assert(a_buffer.exhausted(),false)
    }
}