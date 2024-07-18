// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readInt16_032{

    @TestCase
    func okio_readInt16_032(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            //a_buffer.write(arrb)
            println(a_buffer)
            println(a_buffer.readInt16())
            println(a_buffer)
            println(a_buffer.size)
            println(a_buffer.exhausted())
        } catch (e:IllegalArgumentException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc," size < 2: 0")
    }
    @TestCase
    func okio_readInt16_032_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6]
            let a_buffer = Buffer()
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            //a_buffer.write(arrb)
            println(bufferedSource)
            println(bufferedSource.readInt16())
            println(bufferedSource.exhausted())
        } catch (e:EOFException) {
            println("EOFException")
            exc = "EOFException"
        }
        @Assert(exc,"EOFException")
    }
}