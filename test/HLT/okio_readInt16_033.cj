// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readInt16_033{

    @TestCase
    func okio_readInt16_033(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readInt16())
            println(a_buffer)
            println(a_buffer.size)
            // println(a_buffer.exhausted())
        } catch (e:IllegalArgumentException) {
            // println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 1")
    }
    @TestCase
    func okio_readInt16_033_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readInt16())
            // println(a_buffer.exhausted())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}