

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_readString_018{

    let arrb:Array<Byte> = [1,2,1,2,1,21,2,1,2,1,2]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {
    }
    public override func afterAll(): Unit {
        // a_buffer.writeUtf8(arrb.toString())
        // println("a_buffer.readString() : ${a_buffer.readString().getOrThrow()}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readString(): ?String
    // 删除其中的所有字节，将其解码为默认UTF-8，并返回字符串
    @TestCase
    @Bench[1]
    func okio_readString_018_1(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[10]
    func okio_readString_018_10(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[100]
    func okio_readString_018_100(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[1000]
    func okio_readString_018_1000(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[10000]
    func okio_readString_018_10000(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
}