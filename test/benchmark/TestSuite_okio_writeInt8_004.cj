

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_writeInt8_004{

    let bufferedSink:BufferedSink = Buffer()
    public override func beforeEach(): Unit {

    }
    public override func afterEach(): Unit {
        // // println((bufferedSink as Buffer).getOrThrow())
        // println((bufferedSink as Buffer).getOrThrow().size)
        // (bufferedSink as Buffer).getOrThrow().clear()
    }

    //writeInt8(value: Int64): BufferedSink 向BufferedSink中写入一个int8的字节
    @TestCase
    @Bench[1]
    func okio_writeInt8_004_1(): Unit {
        bufferedSink.writeInt8(255)
    }
    @TestCase
    @Bench[10]
    func okio_writeInt8_004_10(): Unit {
        bufferedSink.writeInt8(255)
    }
    @TestCase
    @Bench[100]
    func okio_writeInt8_004_100(): Unit {
        bufferedSink.writeInt8(255)
    }
    @TestCase
    @Bench[1000]
    func okio_writeInt8_004_1000(): Unit {
        bufferedSink.writeInt8(255)
    }
    @TestCase
    @Bench[10000]
    func okio_writeInt8_004_10000(): Unit {
        bufferedSink.writeInt8(255)
    }
  
}