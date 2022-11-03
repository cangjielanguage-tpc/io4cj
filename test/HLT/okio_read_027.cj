// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_027{

    @TestCase
    func okio_read_027(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.read(arrb2,3,4),4)
        println(arrb2)
        println(a_buffer.size)
        println(a_buffer.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 6,5,4,3]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,3)
        @Assert(a_buffer.exhausted(),false)
    }
}