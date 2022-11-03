// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readByteArray_051{

    @TestCase
    func okio_readByteArray_051(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(a_buffer.readByteArray(9),arrb)
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
}