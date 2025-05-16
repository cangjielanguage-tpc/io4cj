// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_peek_098{

    @TestCase
    func okio_peek_098(): Unit {
        let buffer = Buffer ()
        buffer.writeUtf8("abcdefghi"); 
        @Assert(buffer.readUtf8(3),"abc")
        let peek = buffer.peek()
        @Assert(peek.readUtf8(3),"def")
        @Assert(buffer.readUtf8(3),"def")
        @Assert(buffer.readUtf8(3),"ghi")
        @Assert(peek.readUtf8(3),"ghi")
    }
    @TestCase
    func okio_peek_098_2(): Unit {
        let buffer = Buffer ()
        buffer.writeUtf8("abcdefghi"); 
        let source: Source = buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8(3),"abc")
        let peek = bufferedSource.peek()
        @Assert(peek.readUtf8(3),"def")
        @Assert(bufferedSource.readUtf8(3),"def")
        @Assert(bufferedSource.readUtf8(3),"ghi")
        @Assert(peek.readUtf8(3),"ghi")
    }  
}