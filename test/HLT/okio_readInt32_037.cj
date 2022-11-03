// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt32_037{

    @TestCase
    func okio_readInt32_037(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt32(),Int32(( 6<<8<<8<<8) | 5<<8<<8 | 4<<8| 3))
        @Assert(a_buffer.size,4)
        @Assert(a_buffer.exhausted(),false)
    }
}