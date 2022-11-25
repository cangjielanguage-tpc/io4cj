// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_peek_022{
    let buffer = okio.Buffer()

    public override func beforeAll(): Unit {
        
    }
    public override func afterAll(): Unit {
        // let peek = buffer.peek()
        // println("peek.readUtf8(3) : ${peek.readUtf8(3).getOrThrow()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // peek(): BufferedSource
    // 返回一个新的BufferedSource，它可以从该BufferedResource读取数据，而不使用它。一旦下次读取或关闭此源，返回的源将变为无效。例如，我们可以使用peek（）向前看并多次读取相同的数据。
    @TestCase
    @Bench[1]
    func okio_peek_022_1(): Unit {
        buffer.writeUtf8("abcdefghi")
        let peek = buffer.peek()
        peek.readUtf8(3)
    }
    @TestCase
    @Bench[10]
    func okio_peek_022_10(): Unit {
        buffer.writeUtf8("abcdefghi")
        let peek = buffer.peek()
        peek.readUtf8(3)
    }
    @TestCase
    @Bench[100]
    func okio_peek_022_100(): Unit {
        buffer.writeUtf8("abcdefghi")
        let peek = buffer.peek()
        peek.readUtf8(3)
    }
    @TestCase
    @Bench[1000]
    func okio_peek_022_1000(): Unit {
        buffer.writeUtf8("abcdefghi")
        let peek = buffer.peek()
        peek.readUtf8(3)
    }
    @TestCase
    @Bench[10000]
    func okio_peek_022_10000(): Unit {
        buffer.writeUtf8("abcdefghi")
        let peek = buffer.peek()
        peek.readUtf8(3)
    }
}