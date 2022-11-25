// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_hex_033{

    var i:Int64 = 0
    var bs : ByteString = ByteString("hello world".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.hex()}") //68656c6c6f20776f726c64
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 返回此以十六进制编码的字节字符串 public func hex(): String
    @TestCase
    @Bench[1]
    func okio_hex_033_1(): Unit {
        bs.hex()
    }
    @TestCase
    @Bench[10]
    func okio_hex_033_10(): Unit {
        bs.hex()
    }
    @TestCase
    @Bench[100]
    func okio_hex_033_100(): Unit {
        bs.hex()
    }
    @TestCase
    @Bench[1000]
    func okio_hex_033_1000(): Unit {
        bs.hex()
    }
    @TestCase
    @Bench[10000]
    func okio_hex_033_10000(): Unit {
        bs.hex()
    }
}