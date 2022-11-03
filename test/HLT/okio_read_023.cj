// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_023{

    @TestCase
    func okio_read_023(): Unit {

        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.read(arrb2,5,1),-1)
        println(arrb2)
        println(a_buffer.size)
        println(a_buffer.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 0, 0, 0, 0]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
}