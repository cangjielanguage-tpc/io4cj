// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_writeInt32_006{

    let bufferedSink:BufferedSink = Buffer()
    public override func beforeEach(): Unit {

    }
    public override func afterEach(): Unit {
        // println((bufferedSink as Buffer).getOrThrow())
        // println((bufferedSink as Buffer).getOrThrow().size)
        // (bufferedSink as Buffer).getOrThrow().clear()
    }

    // writeInt32(value: Int64): BufferedSink 向BufferedSink中写入一个大端int32的字节
    @TestCase
    @Bench[1]
    func okio_writeInt32_006_1(): Unit {
        bufferedSink.writeInt32(16909320)
    }
    @TestCase
    @Bench[10]
    func okio_writeInt32_006_10(): Unit {
        bufferedSink.writeInt32(16909320)
    }
    @TestCase
    @Bench[100]
    func okio_writeInt32_006_100(): Unit {
        bufferedSink.writeInt32(16909320)
    }
    @TestCase
    @Bench[1000]
    func okio_writeInt32_006_1000(): Unit {
        bufferedSink.writeInt32(16909320)
    }
    @TestCase
    @Bench[10000]
    func okio_writeInt32_006_10000(): Unit {
        bufferedSink.writeInt32(16909320)
    }
}