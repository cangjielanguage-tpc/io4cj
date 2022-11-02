// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt64_043{

    @TestCase
    func okio_readInt64_043(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,9,11]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt64(),Int64(6<<8<<8<<8<<8<<8<<8<<8 | 5<<8<<8<<8<<8<<8<<8 | 4<<8<<8<<8<<8<<8 | 3<<8<<8<<8<<8 | 2<<8<<8<<8 | 16<<8<<8 | 7<<8 | 9))
        @Assert(a_buffer.size,1)
        @Assert(a_buffer.exhausted(),false)
    }
}