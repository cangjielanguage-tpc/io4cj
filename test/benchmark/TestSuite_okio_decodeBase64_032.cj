

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_decodeBase64_032{

    var bs : ?ByteString = ByteString.decodeBase64("")
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.getOrThrow().toString()}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 对Base64编码的字节进行解码，并将其值作为字节字符串返回。如果base64不是base64编码的字节序列，则返回None。
    // public static func decodeBase64 (base64: String): ?ByteString
    @TestCase
    @Bench[1]
    func okio_decodeBase64_032_1(): Unit {
        bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
    }
    @TestCase
    @Bench[10]
    func okio_decodeBase64_032_10(): Unit {
        bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
    }
    @TestCase
    @Bench[100]
    func okio_decodeBase64_032_100(): Unit {
        bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
    }
    @TestCase
    @Bench[1000]
    func okio_decodeBase64_032_1000(): Unit {
        bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
    }
    @TestCase
    @Bench[10000]
    func okio_decodeBase64_032_10000(): Unit {
        bs = ByteString.decodeBase64("aGVsbG8gd29ybGQ=")
    }
}