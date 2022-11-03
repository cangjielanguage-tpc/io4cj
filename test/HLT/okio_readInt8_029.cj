// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt8_029{

    @TestCase
    func okio_readInt8_029(): Unit {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            @Assert(a_buffer.toString(),"[size=7] [6, 5, 4, 3, 2, 16, 7]")
            @Assert(a_buffer.readInt8(),6)
            @Assert(a_buffer.toString(),"[size=6] [5, 4, 3, 2, 16, 7]")
            @Assert(a_buffer.size,6)
            @Assert(a_buffer.exhausted(),false)
    }
}