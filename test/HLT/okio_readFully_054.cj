// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readFully_054{

    @TestCase
    func okio_readFully_054(): Unit {
        println("----------------------------------------okio_readFully_054---------------------------------")
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2:Array<Byte> = Array<Byte>(10, repeat: 0)
            println(a_buffer)
            println(a_buffer.readFully(arrb2))
        } catch (e:EOFException) {
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
    }
    @TestCase
    func okio_readFully_054_2(): Unit {
        println("----------------------------------------okio_readFully_054_2---------------------------------")
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            let arrb2:Array<Byte> = Array<Byte>(10, repeat: 0)
            bufferedSource.require(1)
            println(bufferedSource)
            println(arrb2)
            println(bufferedSource.readFully(arrb2))
            println(bufferedSource)
            println(arrb2)
        } catch (e:EOFException) {
            // e.printStackTrace()
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
    }
}