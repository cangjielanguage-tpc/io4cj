// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt32_015{

    let arrb:Array<Byte> = [6,5,4,3,2,16,7,128]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.readInt32() : ${a_buffer.readInt32()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readInt32(): Int32
    // 从这个源中删除四个字节，并返回一个大端int32
    @TestCase
    @Bench[1]
    func okio_readInt32_015_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt32()
    }
    @TestCase
    @Bench[10]
    func okio_readInt32_015_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt32()
    }
    @TestCase
    @Bench[100]
    func okio_readInt32_015_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt32()
    }
    @TestCase
    @Bench[1000]
    func okio_readInt32_015_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt32()
    }
    @TestCase
    @Bench[10000]
    func okio_readInt32_015_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readInt32()
    }
}