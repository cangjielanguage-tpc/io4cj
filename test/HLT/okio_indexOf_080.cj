// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_080{

    @TestCase
    func okio_indexOf_080(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.indexOf(5),1)
    }
}