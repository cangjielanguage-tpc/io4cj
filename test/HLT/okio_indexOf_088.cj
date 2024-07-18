// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_indexOf_088{

    @TestCase
    func okio_indexOf_088(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        println(a_buffer.indexOf(5,2,7))
        @Assert(a_buffer.indexOf(5,2,7),4)
    }
    @TestCase
    func okio_indexOf_088_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(bufferedSource.indexOf(5,2,7))
        @Assert(bufferedSource.indexOf(5,2,7),4)
    }
}   