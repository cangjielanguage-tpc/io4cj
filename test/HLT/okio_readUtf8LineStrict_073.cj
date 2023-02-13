// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8LineStrict_073{

    @TestCase
    func okio_readUtf8LineStrict_073(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n")
        @Assert(a_buffer.toString(),"[size=7] [229, 141, 142, 228, 184, 186, 10]")
        @Assert(a_buffer.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.toString(),"[size=0] []")
        @Assert(a_buffer.exhausted(),true)

        a_buffer.writeUtf8("华为\r\n")
        @Assert(a_buffer.toString(),"[size=8] [229, 141, 142, 228, 184, 186, 13, 10]")
        @Assert(a_buffer.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.toString(),"[size=0] []")
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readUtf8LineStrict_073_2(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n")
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(bufferedSource.exhausted(),true)

        a_buffer.writeUtf8("华为\r\n")
        @Assert(bufferedSource.readUtf8LineStrict().getOrThrow(),"华为")
        @Assert(bufferedSource.exhausted(),true)
    }
}