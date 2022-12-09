// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_write_001{

    let arrb:Array<Byte> = [6,5,4,3]
    let source = Buffer()
    let sink = Buffer()

    public override func beforeAll(): Unit {
        // source.clear()
    }
    public override func afterAll(): Unit {}
    public override func beforeEach(): Unit {
        // var i:Int64 = 0
        // source.clear()
        // while(i<1000){
        //     source.write(arrb)
        //     i++
        // }
    }
    public override func afterEach(): Unit {
        // println("sink = ${sink.size}")
        // println("source = ${source.size}")
        // sink.clear()
    }
    @TestCase//write(source: Buffer, byteCount: Int64): Unit 从Source中删除byteCount字节并将其附加到此Sink中
    @Bench[1]
    func okio_write_001_1(): Unit {
        source.write(arrb)
        sink.write(source,3)
    }
    // @TestCase//write(source: Buffer, byteCount: Int64): Unit 从Source中删除byteCount字节并将其附加到此Sink中
    // @Bench[10]
    // func okio_write_001_10(): Unit {
    //     source.write(arrb)
    //     sink.write(source,3)
    // }
    // @TestCase//write(source: Buffer, byteCount: Int64): Unit
    // @Bench[100]
    // func okio_write_001_100(): Unit {
    //     source.write(arrb)
    //     sink.write(source,3)
    // }
    // @TestCase//write(source: Buffer, byteCount: Int64): Unit
    // @Bench[1000]
    // func okio_write_001_1000(): Unit {
    //     source.write(arrb)
    //     sink.write(source,3)
    // }
    @TestCase//write(source: Buffer, byteCount: Int64): Unit
    @Bench[10000]
    func okio_write_001_10000(): Unit {
        source.write(arrb)
        sink.write(source,3)
    }
}