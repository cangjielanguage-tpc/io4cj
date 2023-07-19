// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_getBuffer_001{

    @TestCase//getBuffer(): Buffer 获取buffer类 正常获取
    func okio_getBuffer_001(): Unit {
        let buffer = okio.Buffer()

        println(buffer.getBuffer() is Buffer)
        @Assert(buffer.getBuffer() is Buffer,true)
    }
    @TestCase
    func okio_getBuffer_001_2(): Unit {
        let buffer = okio.Buffer()
        let source: Source = buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        
        println(bufferedSource.getBuffer() is Buffer)
        @Assert(bufferedSource.getBuffer() is Buffer,true)
        
        bufferedSource.close()
        println(bufferedSource.getBuffer() is Buffer)
        @Assert(bufferedSource.getBuffer() is Buffer,true)       
    }
}