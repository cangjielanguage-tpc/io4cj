// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readUtf8LineStrict_076{

    @TestCase
    func okio_readUtf8LineStrict_076(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n中国")
        @Assert(a_buffer.toString(),"[size=13] [229, 141, 142, 228, 184, 186, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.readUtf8LineStrict(6).getOrThrow(),"华为")
        @Assert(a_buffer.size,6)
        @Assert(a_buffer.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.exhausted(),false)

        let a_buffer2 = Buffer()
        a_buffer2.writeUtf8("华为\r\n中国")
        @Assert(a_buffer2.toString(),"[size=14] [229, 141, 142, 228, 184, 186, 13, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.readUtf8LineStrict(6).getOrThrow(),"华为")
        @Assert(a_buffer2.size,6)
        @Assert(a_buffer2.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.exhausted(),false)
    }
    @TestCase
    func okio_readUtf8LineStrict_076_2(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n中国")
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8LineStrict(6).getOrThrow(),"华为")
        @Assert(bufferedSource.exhausted(),false)

        let a_buffer2 = Buffer()
        a_buffer2.writeUtf8("华为\r\n中国")
        let source2: Source = a_buffer2
        let bufferedSource2: BufferedSource = Okio.buffer(source2)
        @Assert(bufferedSource2.readUtf8LineStrict(6).getOrThrow(),"华为")
        @Assert(bufferedSource2.exhausted(),false)
    }
}