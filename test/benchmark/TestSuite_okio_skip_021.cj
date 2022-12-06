// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_skip_021{
    let arrb:Array<Byte> = [6,5,4,3,2,16,7,128]
    let a_buffer = Buffer()

    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("a_buffer.skip(1) : ${a_buffer.skip(1)}")
    }

    public override func beforeEach(): Unit {
        
    }
    public override func afterEach(): Unit {
    }

    // skip(byteCount: Int64): Unit
    // 从此源读取并丢弃byteCount字节。如果源在请求的字节被跳过之前耗尽, 抛出EOFException.
    @TestCase
    @Bench[1]
    func okio_skip_021_1(): Unit {
        a_buffer.write(arrb)
        a_buffer.skip(1)
    }
    @TestCase
    @Bench[10]
    func okio_skip_021_10(): Unit {
        a_buffer.write(arrb)
        a_buffer.skip(1)
    }
    @TestCase
    @Bench[100]
    func okio_skip_021_100(): Unit {
        a_buffer.write(arrb)
        a_buffer.skip(1)
    }
    @TestCase
    @Bench[1000]
    func okio_skip_021_1000(): Unit {
        a_buffer.write(arrb)
        a_buffer.skip(1)
    }
    @TestCase
    @Bench[10000]
    func okio_skip_021_10000(): Unit {
        a_buffer.write(arrb)
        a_buffer.skip(1)
    }
}