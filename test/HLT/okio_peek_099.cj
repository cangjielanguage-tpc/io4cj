// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_peek_099{

    @TestCase
    func okio_peek_099(): Unit {
        var exc = ""
        try {
            let buffer = okio.Buffer()
            let peek = buffer.peek()
            println(peek.readUtf8(3))
        } catch (e:NoneValueException) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc="NoneValueException"
        }
        @Assert(exc,"NoneValueException")
    }   
}