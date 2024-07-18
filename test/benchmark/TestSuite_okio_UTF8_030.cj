

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_UTF8_030{

    var bs : ByteString = ByteString("hello world".toUtf8Array())
    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        println("bs = ${bs.UTF8()}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // 返回包含UTF-8字节的新字节字符串。public func UTF8(): String
    @TestCase
    @Bench[1]
    func okio_UTF8_030_1(): Unit {
        bs.UTF8()
    }
    @TestCase
    @Bench[10]
    func okio_UTF8_030_10(): Unit {
        bs.UTF8()
    }
    @TestCase
    @Bench[100]
    func okio_UTF8_030_100(): Unit {
        bs.UTF8()
    }
    @TestCase
    @Bench[1000]
    func okio_UTF8_030_1000(): Unit {
        bs.UTF8()
    }
    @TestCase
    @Bench[10000]
    func okio_UTF8_030_10000(): Unit {
        bs.UTF8()
    }
}