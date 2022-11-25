// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_exhausted_009{

    let arrb:Array<Byte> = [6,5,4,3,2,16,7]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println(a_buffer.exhausted())
    }

    public override func beforeEach(): Unit {
        // a_buffer.write(arrb)
    }
    public override func afterEach(): Unit {
    }

    // exhausted(): Bool BufferedSource 有字节 & BufferedSource 没有更多字节
    @TestCase
    @Bench[1]
    func okio_exhausted_009_1(): Unit {
        a_buffer.exhausted()
    }
    @TestCase
    @Bench[10]
    func okio_exhausted_009_10(): Unit {
        a_buffer.exhausted()
    }
    @TestCase
    @Bench[100]
    func okio_exhausted_009_100(): Unit {
        a_buffer.exhausted()
    }
    @TestCase
    @Bench[1000]
    func okio_exhausted_009_1000(): Unit {
        a_buffer.exhausted()
    }
    @TestCase
    @Bench[10000]
    func okio_exhausted_009_10000(): Unit {
        a_buffer.exhausted()
    }
}