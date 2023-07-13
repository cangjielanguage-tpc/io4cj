// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

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