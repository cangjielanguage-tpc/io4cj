

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readUtf8LineStrict_019{
    let a_buffer = Buffer()
    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.readUtf8LineStrict() : ${a_buffer.readUtf8LineStrict().getOrThrow()}")
        // println("a_buffer : ${a_buffer.readUtf8().getOrThrow()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readUtf8LineStrict(): ?String 
    // 删除并返回最多但不包括下一个换行符的字符。换行符为“\n”或“\r\n”；这些字符不包含在结果中。
    @TestCase
    @Bench[1]
    func okio_readUtf8LineStrict_019_1(): Unit {
        a_buffer.writeUtf8("华为\n中国")
        a_buffer.readUtf8LineStrict()
    }
    @TestCase
    @Bench[10]
    func okio_readUtf8LineStrict_019_10(): Unit {
        a_buffer.writeUtf8("华为\n中国")
        a_buffer.readUtf8LineStrict()
    }
    @TestCase
    @Bench[100]
    func okio_readUtf8LineStrict_019_100(): Unit {
        a_buffer.writeUtf8("华为\n中国")
        a_buffer.readUtf8LineStrict()
    }
    @TestCase
    @Bench[1000]
    func okio_readUtf8LineStrict_019_1000(): Unit {
        a_buffer.writeUtf8("华为\n中国")
        a_buffer.readUtf8LineStrict()
    }
    @TestCase
    @Bench[10000]
    func okio_readUtf8LineStrict_019_10000(): Unit {
        a_buffer.writeUtf8("华为\n中国")
        a_buffer.readUtf8LineStrict()
    }
}