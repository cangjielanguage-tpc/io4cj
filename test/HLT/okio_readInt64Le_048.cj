// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt64Le_048{

    @TestCase
    func okio_readInt64Le_048(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readInt64Le())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 8: 0")
    }
}