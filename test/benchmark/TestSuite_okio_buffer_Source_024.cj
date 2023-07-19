

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_buffer_Source_024{

    let source:Source = Buffer()
    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("source is Buffer?: ${source is Buffer}")
        // println("source is Source?: ${source is Source}")
        // println("source is Sink?: ${source is Sink}")
        // println("Okio.buffer(source) is BufferedSink?: ${Okio.buffer(source) is BufferedSink}")
        // println("Okio.buffer(source) is Bufferedsource?: ${Okio.buffer(source) is BufferedSource}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // buffer(source: Source): BufferedSource 
    // 返回缓冲从Source读取的新Source。返回的BufferedSource将对其内存缓冲区执行批量读取。
    @TestCase
    @Bench[1]
    func okio_buffer_Source_024_1(): Unit {
        Okio.buffer(source)
    }
    @TestCase
    @Bench[10]
    func okio_buffer_Source_024_10(): Unit {
        Okio.buffer(source)
    }
    @TestCase
    @Bench[100]
    func okio_buffer_Source_024_100(): Unit {
        Okio.buffer(source)
    }
    @TestCase
    @Bench[1000]
    func okio_buffer_Source_024_1000(): Unit {
        Okio.buffer(source)
    }
    @TestCase
    @Bench[10000]
    func okio_buffer_Source_024_10000(): Unit {
        Okio.buffer(source)
    }
}