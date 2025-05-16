// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readByteArray_050 {

    @TestCase
    func okio_readByteArray_050(): Unit {
        let a_buffer = Buffer()
        @Assert(a_buffer.toString(),"[size=0] []")
        a_buffer.readByteArray()
        @Assert(a_buffer.toString(),"[size=0] []")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readByteArray_050_2(): Unit {
        let a_buffer = Buffer()
        @Assert(a_buffer.toString(),"[size=0] []")
        
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        bufferedSource.readByteArray()
        @Assert(bufferedSource.exhausted(),true)
    }
}