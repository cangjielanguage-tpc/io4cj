// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt64_045{

    @TestCase
    func okio_readInt64_045(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer.readInt64())
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 8: 0")
    }
}