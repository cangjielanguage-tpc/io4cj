// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8Line_071{

    @TestCase
    func okio_readUtf8Line_071(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readUtf8Line().getOrThrow())
        } catch (e:NoneValueException) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc="NoneValueException"
        }
        @Assert(exc,"NoneValueException")
    }
}