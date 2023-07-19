// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

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
    @TestCase
    func okio_peek_099_2(): Unit {
        var exc = ""
        try {
            let buffer = okio.Buffer()
            let source: Source = buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            let peek = bufferedSource.peek()
            println(peek.readUtf8(3))
        } catch (e:NoneValueException) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc="NoneValueException"
        }
        @Assert(exc,"NoneValueException")
    }   
}