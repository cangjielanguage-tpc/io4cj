// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readFully_056{

    @TestCase
    func okio_readFully_056(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let a_buffer2 = Buffer()
            println(a_buffer)
            println(a_buffer.readFully(a_buffer2,10))
        } catch (e:Exception) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
    }
    @TestCase
    func okio_readFully_056_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            let a_buffer2 = Buffer()
            println(bufferedSource)
            println(bufferedSource.readFully(a_buffer2,10))
        } catch (e:Exception) {
            println(e.message)
            exc=e.message
        }
        @Assert(exc.contains("EOFException"),true)
    }
}