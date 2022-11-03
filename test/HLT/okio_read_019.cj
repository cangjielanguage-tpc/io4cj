// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_019{

    @TestCase
    func okio_read_019(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        let arrb2 :Array<Byte> = Array<Byte>(0,item:0)
        @Assert(a_buffer.read(arrb2),Int64(-1))
        println(a_buffer.size)
        @Assert(a_buffer.size,0)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),true)
    }
}