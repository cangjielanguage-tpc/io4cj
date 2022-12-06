// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_hashCode_037{

    var bs : ByteString = ByteString("hello world".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.hashCode()}") //1923188771
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 获得实例类型的哈希值 hashCode()
    @TestCase
    @Bench[1]
    func okio_hashCode_037_1(): Unit {
        bs.hashCode()
    }
    @TestCase
    @Bench[10]
    func okio_hashCode_037_10(): Unit {
        bs.hashCode()
    }
    @TestCase
    @Bench[100]
    func okio_hashCode_037_100(): Unit {
        bs.hashCode()
    }
    @TestCase
    @Bench[1000]
    func okio_hashCode_037_1000(): Unit {
        bs.hashCode()
    }
    @TestCase
    @Bench[10000]
    func okio_hashCode_037_10000(): Unit {
        bs.hashCode()
    }
}