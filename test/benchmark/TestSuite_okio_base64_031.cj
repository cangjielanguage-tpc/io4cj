

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_base64_031{

    var bs : ByteString = ByteString("hello world".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.base64()}") //aGVsbG8gd29ybGQ=
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 通过将字节解码为UTF-8来构造新字符串。public func base64 (): String
    @TestCase
    @Bench[1]
    func okio_base64_031_1(): Unit {
        bs.base64()
    }
    @TestCase
    @Bench[10]
    func okio_base64_031_10(): Unit {
        bs.base64()
    }
    @TestCase
    @Bench[100]
    func okio_base64_031_100(): Unit {
        bs.base64()
    }
    @TestCase
    @Bench[1000]
    func okio_base64_031_1000(): Unit {
        bs.base64()
    }
    @TestCase
    @Bench[10000]
    func okio_base64_031_10000(): Unit {
        bs.base64()
    }
}