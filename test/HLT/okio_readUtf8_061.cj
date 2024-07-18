// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readUtf8_061{

    @TestCase
    func okio_readUtf8_061(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        @Assert(a_buffer.toString(),"[size=6] [91, 49, 44, 32, 50, 93]")
        @Assert(a_buffer.readUtf8(3),"[1,")
        @Assert(a_buffer.size,3)
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_readUtf8_061_2(): Unit {
        let arrb:Array<Byte> = [1,2]
        let a_buffer = Buffer()
        a_buffer.writeUtf8(arrb.toString())
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8(3),"[1,")
        @Assert(bufferedSource.exhausted(),false)
    }
}