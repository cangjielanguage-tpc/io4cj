

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readInt64_016{
    let arrb:Array<Byte> = [6,5,4,3,2,16,7,128,6,5,4,3,2,16,7,128]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.readInt64() : ${a_buffer.readInt64()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readInt64(): Int64
    // 从这个源中删除八个字节，并返回一个大端int64
    @TestCase
    @Bench[1]
    func okio_readInt64_016_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt64()
    }
    @TestCase
    @Bench[10]
    func okio_readInt64_016_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt64()
    }
    @TestCase
    @Bench[100]
    func okio_readInt64_016_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt64()
    }
    @TestCase
    @Bench[1000]
    func okio_readInt64_016_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt64()
    }
    @TestCase
    @Bench[10000]
    func okio_readInt64_016_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt64()
    }
}