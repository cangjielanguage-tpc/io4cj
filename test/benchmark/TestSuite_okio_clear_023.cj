// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_clear_023{

    let arrb:Array<Byte> = [6,5,4,3]
    let sink = Buffer()

    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        // println("sink = ${sink.size}")
        // sink.clear()
    }
    // clear(): Unit 
    // 丢弃此缓冲区中的所有字节。在完成缓冲区时调用此方法会将其段返回到池中。
    @TestCase
    @Bench[1]
    func okio_clear_023_1(): Unit {
        sink.write(arrb)
        sink.clear()
    }
    @TestCase
    @Bench[10]
    func okio_clear_023_10(): Unit {
        sink.write(arrb)
        sink.clear()
    }
    @TestCase
    @Bench[100]
    func okio_clear_023_100(): Unit {
        sink.write(arrb)
        sink.clear()
    }
    @TestCase
    @Bench[1000]
    func okio_clear_023_1000(): Unit {
        sink.write(arrb)
        sink.clear()
    }
    @TestCase
    @Bench[10000]
    func okio_clear_023_10000(): Unit {
        sink.write(arrb)
        sink.clear()
    }
}