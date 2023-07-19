

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class  okio_writeUtf8_003 {

    let bufferedSink:BufferedSink = Buffer()
    public override func beforeEach(): Unit {

    }
    public override func afterEach(): Unit {
        // println((bufferedSink as Buffer).getOrThrow().readUtf8().getOrThrow().size)
        // (bufferedSink as Buffer).getOrThrow().clear()
    }
    // writeUtf8(string: String): BufferedSink 向BufferedSink中写入UTF-8编码的字符串
    @TestCase
    @Bench[1]
    func okio_writeUtf8_003_1(): Unit {
        bufferedSink.writeUtf8("1234567890")
    }
    @TestCase
    @Bench[10]
    func okio_writeUtf8_003_10(): Unit {
        bufferedSink.writeUtf8("1234567890")
    }
    @TestCase
    @Bench[100]
    func okio_writeUtf8_003_100(): Unit {
        bufferedSink.writeUtf8("1234567890")
    }
    @TestCase
    @Bench[1000]
    func okio_writeUtf8_003_1000(): Unit {
        bufferedSink.writeUtf8("1234567890")
    }
    @TestCase
    @Bench[10000]
    func okio_writeUtf8_003_10000(): Unit {
        bufferedSink.writeUtf8("1234567890")
    }

}