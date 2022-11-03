// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readByteArray_050 {

    @TestCase
    func okio_readByteArray_050(): Unit {
        let a_buffer = Buffer()
        @Assert(a_buffer.toString(),"[size=0] []")
        a_buffer.readByteArray()
        @Assert(a_buffer.toString(),"[size=0] []")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
}