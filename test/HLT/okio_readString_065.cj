// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readString_065{

    @TestCase
    func okio_readString_065(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            println(a_buffer)
            println(a_buffer.readString().getOrThrow())
            println(a_buffer)
        } catch (e:NoneValueException) {
            // e.printStackTrace()
            // println("e.message = ${e.message}")
            exc="NoneValueException"
        }
        @Assert(exc,"NoneValueException")
    }
}