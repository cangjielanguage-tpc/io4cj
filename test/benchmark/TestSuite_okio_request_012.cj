

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_request_012{
    var i:Int64 = 0
    let arrb:Array<Byte> = [6,5,4,3,2,16,7]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {
        a_buffer.write(arrb)
    }
    public override func afterAll(): Unit {
        // println("a_buffer.request(8) : ${a_buffer.request(8)}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // request(byteCount: Int64): Bool
    // 当缓冲区至少包含byteCount字节时，返回true，并根据需要进行扩展。
    // 如果源在读取请求的字节之前耗尽，则返回false。
    @TestCase
    @Bench[1]
    func okio_request_012_1(): Unit {
        a_buffer.request(8)
    }
    @TestCase
    @Bench[10]
    func okio_request_012_10(): Unit {
        a_buffer.request(8)
    }
    @TestCase
    @Bench[100]
    func okio_request_012_100(): Unit {
        a_buffer.request(8)
    }
    @TestCase
    @Bench[1000]
    func okio_request_012_1000(): Unit {
        a_buffer.request(8)
    }
    @TestCase
    @Bench[10000]
    func okio_request_012_10000(): Unit {
        a_buffer.request(8)
    }
}