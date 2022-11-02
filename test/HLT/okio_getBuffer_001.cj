// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getBuffer_001{

    @TestCase//getBuffer(): Buffer 获取buffer类 正常获取
    func okio_getBuffer_001(): Unit {
        let buffer = Buffer()
        let source: Source = buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        
        println(bufferedSource.getBuffer() is Buffer)
        @Assert(bufferedSource.getBuffer() is Buffer,true)
    }
}