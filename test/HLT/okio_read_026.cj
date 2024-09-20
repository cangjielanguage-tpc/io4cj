// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_read_026{

    @TestCase
    func okio_read_026(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7, repeat: 0)
            println(a_buffer.read(arrb2,3,5))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
    @TestCase
    func okio_read_026_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let arrb2 :Array<Byte> = Array<Byte>(7, repeat: 0)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.read(arrb2,3,5))
        } catch (e:ArrayIndexOutOfBoundsException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException:"),true)
    }
}