// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readUtf8_060{

    @TestCase
    func okio_readUtf8_060(): Unit {
        let a_buffer = Buffer()
        println(a_buffer)
        @Assert(a_buffer.readUtf8(), "")
    }
    @TestCase
    func okio_readUtf8_060_2(): Unit {
        let a_buffer = Buffer()
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        println(bufferedSource)
        @Assert(bufferedSource.readUtf8(), "")
    }
}