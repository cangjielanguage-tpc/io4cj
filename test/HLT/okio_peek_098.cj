// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_peek_098{

    @TestCase
    func okio_peek_098(): Unit {
        let buffer = okio.Buffer ()
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
        let buffer = okio.Buffer ()
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