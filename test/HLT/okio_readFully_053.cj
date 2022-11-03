// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readFully_053{

    @TestCase
    func okio_readFully_053(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2:Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        a_buffer.readFully(arrb2)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,2)
        @Assert(a_buffer.exhausted(),false)
    }
}