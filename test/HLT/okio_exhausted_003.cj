// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_exhausted_003{

    @TestCase//exhausted(): Bool BufferedSource 有字节 & BufferedSource 没有更多字节
    func okio_exhausted_003(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),true)
        a_buffer.write(arrb)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),false)
    }
}