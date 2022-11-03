// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_087{

    @TestCase
    func okio_indexOf_087(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        println(a_buffer.indexOf(4,1,7))
        @Assert(a_buffer.indexOf(4,1,7),2)
    }
}   