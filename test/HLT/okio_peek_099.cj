// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_peek_099{

    @TestCase
    func okio_peek_099(): Unit {
        var exc = ""
        try {
            let buffer = Buffer()
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
            let buffer = Buffer()
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