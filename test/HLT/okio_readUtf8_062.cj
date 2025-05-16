// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readUtf8_062{

    @TestCase
    func okio_readUtf8_062(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [1,2]
            let a_buffer = Buffer()
            a_buffer.writeUtf8(arrb.toString())
            println(a_buffer)
            println(a_buffer.readUtf8(7))
            println(a_buffer)
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase
    func okio_readUtf8_062_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [1,2]
            let a_buffer = Buffer()
            a_buffer.writeUtf8(arrb.toString())
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource)
            println(bufferedSource.readUtf8(7))
            println(bufferedSource)
        } catch (e:EOFException) {
            //e.printStackTrace()
            println("e.message = EOFException")
            exc="EOFException"
        }
        @Assert(exc.contains("EOFException"),true)
    }
}