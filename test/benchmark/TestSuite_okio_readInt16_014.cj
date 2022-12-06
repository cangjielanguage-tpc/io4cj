// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt16_014 {
    let arrb:Array<Byte> = [6,5,4,3,2,16,7]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // println("a_buffer.readInt16() : ${a_buffer.readInt16()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readInt16(): Int16
    // 从这个源中删除两个字节，并返回一个大端int16
    @TestCase
    @Bench[1]
    func okio_readInt16_014_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt16()
    }
    @TestCase
    @Bench[10]
    func okio_readInt16_014_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt16()
    }
    @TestCase
    @Bench[100]
    func okio_readInt16_014_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt16()
    }
    @TestCase
    @Bench[1000]
    func okio_readInt16_014_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt16()
    }
    @TestCase
    @Bench[10000]
    func okio_readInt16_014_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt16()
    }
}