

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_002 {

    let arrb:Array<Byte> = [6,5,4,3]
    let sink = Buffer()
    let source = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {}
    public override func beforeEach(): Unit {}
    public override func afterEach(): Unit {}

    @TestCase//read(sink: Buffer, byteCount: Int64): Int64 从Source中删除至少1个字节，并将它们附加到Sink中。
    @Bench[1]
    func okio_read_002_1(): Unit {
        source.write(arrb)
        source.read(sink,3)
    }
    @TestCase//read(sink: Buffer, byteCount: Int64): Int64
    @Bench[10]
    func okio_read_002_10(): Unit {
        source.write(arrb)
        source.read(sink,3)
    }
    @TestCase//read(sink: Buffer, byteCount: Int64): Int64
    @Bench[100]
    func okio_read_002_100(): Unit {
        source.write(arrb)
        source.read(sink,3)
    }
    @TestCase//read(sink: Buffer, byteCount: Int64): Int64
    @Bench[1000]
    func okio_read_002_1000(): Unit {
        source.write(arrb)
        source.read(sink,3)
    }
        @TestCase//read(sink: Buffer, byteCount: Int64): Int64
    @Bench[10000]
    func okio_read_002_10000(): Unit {
        source.write(arrb)
        source.read(sink,3)
    }
}