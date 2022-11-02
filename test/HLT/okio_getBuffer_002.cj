// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getBuffer_002{

    @TestCase//getBuffer(): Buffer 获取buffer类 获取之后 可读
    func okio_getBuffer_002(): Unit {
        let buffer = Buffer()
        buffer.write([6, 5, 4, 3, 2, 16, 7])
              .writeUtf8("华为")
        
        let source: Source = buffer
        
        let bufferedSource: BufferedSource = Okio.buffer(source)
        
        println(bufferedSource)
        println(bufferedSource.request(3))
        println(bufferedSource.getBuffer())
        @Assert(bufferedSource.getBuffer().toString(),"[size=13] [6, 5, 4, 3, 2, 16, 7, 229, 141, 142, 228, 184, 186]")
        println(bufferedSource.getBuffer() is Buffer)
        @Assert(bufferedSource.getBuffer() is Buffer,true)
    }
}