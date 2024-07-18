

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readInt8_013 {
    let arrb:Array<Byte> = [6,5,4,3,2,16,7]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.readInt8() : ${a_buffer.readInt8()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readInt8(): Int8
    // 从这个source中删除一个字节并返回它

    @TestCase
    @Bench[1]
    func okio_readInt8_013_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt8()
    }
    @TestCase
    @Bench[10]
    func okio_readInt8_013_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt8()
    }
    @TestCase
    @Bench[100]
    func okio_readInt8_013_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt8()
    }
    @TestCase
    @Bench[1000]
    func okio_readInt8_013_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt8()
    }
    @TestCase
    @Bench[10000]
    func okio_readInt8_013_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt8()
    }
}