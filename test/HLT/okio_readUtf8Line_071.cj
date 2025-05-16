// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

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
    @TestCase
    func okio_readUtf8Line_071_2(): Unit {
        var exc = ""
        try {
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readUtf8Line().getOrThrow())
        } catch (e:NoneValueException) {
            // e.printStackTrace()
            println("e.message = ${e.message}")
            exc="NoneValueException"
        }
        @Assert(exc,"NoneValueException")
    }
}