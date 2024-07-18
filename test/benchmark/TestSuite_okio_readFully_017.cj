

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readFully_017{
    let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
    let a_buffer = Buffer()
    let arrb2:Array<Byte> = Array<Byte>(7,item:0)

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.readFully(arrb2) : ${a_buffer.readFully(arrb2)}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // readFully(sink: Array<Byte>): Unit
    // 从中精确删除BufferedSink长度的字节，并将其复制到数组中。
    @TestCase
    @Bench[1]
    func okio_readFully_017_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.readFully(arrb2)
    }
    @TestCase
    @Bench[10]
    func okio_readFully_017_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.readFully(arrb2)
    }
    @TestCase
    @Bench[100]
    func okio_readFully_017_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.readFully(arrb2)
    }
    @TestCase
    @Bench[1000]
    func okio_readFully_017_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readFully(arrb2)
    }
    @TestCase
    @Bench[10000]
    func okio_readFully_017_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.readFully(arrb2)
    }
}