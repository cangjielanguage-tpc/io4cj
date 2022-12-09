// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_require_010{

    let arrb:Array<Byte> = [6,5,4,3,2,16,7]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.require(6) : ${a_buffer.require(6)}")
    }

    public override func beforeEach(): Unit {
        a_buffer.write(arrb)
    }
    public override func afterEach(): Unit {
    }

    // require(byteCount: Int64): Unit byteCount < BufferedSource长度 没有处理 不抛异常
    @TestCase
    @Bench[1]
    func okio_require_010_1(): Unit {
        a_buffer.require(6)
    }
    @TestCase
    @Bench[10]
    func okio_require_010_10(): Unit {
        a_buffer.require(6)
    }
    @TestCase
    @Bench[100]
    func okio_require_010_100(): Unit {
        a_buffer.require(6)
    }
    @TestCase
    @Bench[1000]
    func okio_require_010_1000(): Unit {
        a_buffer.require(6)
    }
    @TestCase
    @Bench[10000]
    func okio_require_010_10000(): Unit {
        a_buffer.require(6)
    }
}