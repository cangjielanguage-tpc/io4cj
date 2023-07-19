

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_decodeHex_034{

    var i:Int64 = 0
    var bs : ByteString = ByteString("hello".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.toString()}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 对十六进制编码的字节进行解码，并以字节字符串的形式返回其值。
    // public static func decodeHex(hex: String): ByteString
    @TestCase
    @Bench[1]
    func okio_decodeHex_034_1(): Unit {
        bs = ByteString.decodeHex("68656c6c6f20776f726c64")
    }
    @TestCase
    @Bench[10]
    func okio_decodeHex_034_10(): Unit {
        bs = ByteString.decodeHex("68656c6c6f20776f726c64")
    }
    @TestCase
    @Bench[100]
    func okio_decodeHex_034_100(): Unit {
        bs = ByteString.decodeHex("68656c6c6f20776f726c64")
    }
    @TestCase
    @Bench[1000]
    func okio_decodeHex_034_1000(): Unit {
        bs = ByteString.decodeHex("68656c6c6f20776f726c64")
    }
    @TestCase
    @Bench[10000]
    func okio_decodeHex_034_10000(): Unit {
        bs = ByteString.decodeHex("68656c6c6f20776f726c64")
    }
}