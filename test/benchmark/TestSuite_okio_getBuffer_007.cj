// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_getBuffer_007{
    var buffer = Buffer()
    let source: Source = buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)

    public override func beforeEach(): Unit {
        buffer.writeUtf8("华为")
    }
    public override func afterEach(): Unit {
    }

    // getBuffer(): Buffer 获取buffer类
    @TestCase
    @Bench[1]
    func okio_getBuffer_007_1(): Unit {
        bufferedSource.getBuffer()
    }
    @TestCase
    @Bench[10]
    func okio_getBuffer_007_10(): Unit {
        bufferedSource.getBuffer()
    }
    @TestCase
    @Bench[100]
    func okio_getBuffer_007_100(): Unit {
        bufferedSource.getBuffer()
    }
    @TestCase
    @Bench[1000]
    func okio_getBuffer_007_1000(): Unit {
        bufferedSource.getBuffer()
    }
    @TestCase
    @Bench[10000]
    func okio_getBuffer_007_10000(): Unit {
        bufferedSource.getBuffer()
    }
}