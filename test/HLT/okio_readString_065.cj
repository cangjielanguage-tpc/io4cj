// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readString_065{

    @TestCase
    func okio_readString_065(): Unit {
        let a_buffer = Buffer()
        println(a_buffer)
        @Assert(a_buffer.readString(), "")
        println(a_buffer)
    }
    @TestCase
    func okio_readString_065_2(): Unit {
        let a_buffer = Buffer()
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(a_buffer)
        @Assert(bufferedSource.readString(), "")
        println(a_buffer)
    }
}