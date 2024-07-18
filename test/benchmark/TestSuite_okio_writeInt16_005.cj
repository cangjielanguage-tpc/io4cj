

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_writeInt16_005{

    let bufferedSink:BufferedSink = Buffer()
    var i:Int64 = 0
    public override func beforeEach(): Unit {

    }
    public override func afterEach(): Unit {
        // println((bufferedSink as Buffer).getOrThrow())
        // println((bufferedSink as Buffer).getOrThrow().size)
        // (bufferedSink as Buffer).getOrThrow().clear()
    }

    // writeInt16(value: Int64): BufferedSink 向BufferedSink中写入一个大端int16的字节
    @TestCase
    @Bench[1]
    func okio_writeInt16_005_1(): Unit {
        bufferedSink.writeInt16(256)
    }
    @TestCase
    @Bench[10]
    func okio_writeInt16_005_10(): Unit {
        bufferedSink.writeInt16(256)
    }
    @TestCase
    @Bench[100]
    func okio_writeInt16_005_100(): Unit {
        bufferedSink.writeInt16(256)
    }
    @TestCase
    @Bench[1000]
    func okio_writeInt16_005_1000(): Unit {
        bufferedSink.writeInt16(256)
    }
    @TestCase
    @Bench[10000]
    func okio_writeInt16_005_10000(): Unit {
        bufferedSink.writeInt16(256)
    }
}