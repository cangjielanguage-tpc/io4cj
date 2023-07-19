// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

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