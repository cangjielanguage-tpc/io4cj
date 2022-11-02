// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_peek_098{

    @TestCase
    func okio_peek_098(): Unit {
        let buffer = okio.Buffer ()
        buffer.writeUtf8("abcdefghi"); 
        @Assert(buffer.readUtf8(3).getOrThrow(),"abc")
        let peek = buffer.peek()
        @Assert(peek.readUtf8(3).getOrThrow(),"def")
        @Assert(buffer.readUtf8(3).getOrThrow(),"def")
        @Assert(buffer.readUtf8(3).getOrThrow(),"ghi")
        @Assert(peek.readUtf8(3).getOrThrow(),"ghi")
    }   
}