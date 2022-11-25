// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class  okio_readString_038{

    let arrb:Array<Byte> = [1,2,1,2,1,21,2,1,2,1,2,2,1,2,1,2]
    let a_buffer = Buffer()
    var i = 0

    public override func beforeAll(): Unit {
        while(i < 1024 * 64) {
            a_buffer.writeUtf8(arrb.toString())
            i++
        }
        println("a_buffer.size : ${a_buffer.size}")
        println("arrb.toString() : ${arrb.toString().utf8View.size}")
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
    func  okio_readString_038_1(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[10]
    func  okio_readString_038_10(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[100]
    func  okio_readString_038_100(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[1000]
    func  okio_readString_038_1000(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
    @TestCase
    @Bench[10000]
    func  okio_readString_038_10000(): Unit {
        a_buffer.writeUtf8(arrb.toString())
        a_buffer.readString()
    }
}