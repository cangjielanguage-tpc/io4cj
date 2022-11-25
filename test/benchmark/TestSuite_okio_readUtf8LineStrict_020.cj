// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readUtf8LineStrict_020{
    let a_buffer = Buffer()
    public override func beforeAll(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
    }
    public override func afterAll(): Unit {
        // println("a_buffer.readUtf8LineStrict(12) : ${a_buffer.readUtf8LineStrict(12).getOrThrow()}")
        // println("a_buffer : ${a_buffer.readUtf8().getOrThrow()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readUtf8LineStrict(limit: Int64): ?String 
    // 与readUtf8LineStrict（）类似，但这允许调用者指定允许的最长匹配。使用此选项可防止不包含“\n”或“\r\n”的流。返回的字符串最多只能包含UTF-8字节，扫描的最大字节数为limit+2。如果limit==0，则始终会引发EOFException，因为不会扫描任何字节。
    @TestCase
    @Bench[1]
    func okio_readUtf8LineStrict_020_1(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
        a_buffer.readUtf8LineStrict(12)
    }
    @TestCase
    @Bench[10]
    func okio_readUtf8LineStrict_020_10(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
        a_buffer.readUtf8LineStrict(12)
    }
    @TestCase
    @Bench[100]
    func okio_readUtf8LineStrict_020_100(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
        a_buffer.readUtf8LineStrict(12)
    }
    @TestCase
    @Bench[1000]
    func okio_readUtf8LineStrict_020_1000(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
        a_buffer.readUtf8LineStrict(12)
    }
    @TestCase
    @Bench[10000]
    func okio_readUtf8LineStrict_020_10000(): Unit {
        a_buffer.writeUtf8("华为\r\n中国")
        a_buffer.readUtf8LineStrict(12)
    }
}