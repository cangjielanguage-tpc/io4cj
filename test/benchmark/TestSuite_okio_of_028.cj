

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_of_028{

    var bs : ByteString = ByteString("123".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("bs = ${bs.toString()}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 返回包含数据字节克隆的新字节字符串。public static func of (data: Array<Byte>): ByteString
    @TestCase
    @Bench[1]
    func okio_of_028_1(): Unit {
        bs = ByteString.of("hello world".toUtf8Array())
    }
    @TestCase
    @Bench[10]
    func okio_of_028_10(): Unit {
        bs = ByteString.of("hello world".toUtf8Array())
    }
    @TestCase
    @Bench[100]
    func okio_of_028_100(): Unit {
        bs = ByteString.of("hello world".toUtf8Array())
    }
    @TestCase
    @Bench[1000]
    func okio_of_028_1000(): Unit {
        bs = ByteString.of("hello world".toUtf8Array())
    }
    @TestCase
    @Bench[10000]
    func okio_of_028_10000(): Unit {
        bs = ByteString.of("hello world".toUtf8Array())
    }
}