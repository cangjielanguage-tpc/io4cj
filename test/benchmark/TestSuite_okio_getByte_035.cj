// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_getByte_035{

    var bs : ByteString = ByteString("hello world".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.getByte(10)}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 返回位置处的字节。public func getByte (pos: Int64): Byte
    @TestCase
    @Bench[1]
    func okio_getByte_035_1(): Unit {
        bs.getByte(10)
    }
    @TestCase
    @Bench[10]
    func okio_getByte_035_10(): Unit {
        bs.getByte(10)
    }
    @TestCase
    @Bench[100]
    func okio_getByte_035_100(): Unit {
        bs.getByte(10)
    }
    @TestCase
    @Bench[1000]
    func okio_getByte_035_1000(): Unit {
        bs.getByte(10)
    }
    @TestCase
    @Bench[10000]
    func okio_getByte_035_10000(): Unit {
        bs.getByte(10)
    }
}