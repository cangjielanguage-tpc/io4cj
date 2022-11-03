// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8LineStrict_072{

    @TestCase
    func okio_readUtf8LineStrict_072(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n中国")
        @Assert(a_buffer.toString(),"[size=13] [229, 141, 142, 228, 184, 186, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(a_buffer.size,6)
        @Assert(a_buffer.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.exhausted(),false)

        let a_buffer2 = Buffer()
        a_buffer2.writeUtf8("华为\r\n中国")
        @Assert(a_buffer2.toString(),"[size=14] [229, 141, 142, 228, 184, 186, 13, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(a_buffer2.size,6)
        @Assert(a_buffer2.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.exhausted(),false)
    }
}