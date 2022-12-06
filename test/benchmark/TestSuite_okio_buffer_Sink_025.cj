// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_buffer_Sink_025{

    let sink:Sink = Buffer()
    public override func beforeAll(): Unit {}
    public override func afterAll(): Unit {
        // println("sink is Buffer?: ${sink is Buffer}")
        // println("sink is Sink?: ${sink is Sink}")
        // println("sink is Source?: ${sink is Source}")
        // println("Okio.buffer(sink) is BufferedSink?: ${Okio.buffer(sink) is BufferedSink}")
        // println("Okio.buffer(sink) is BufferedSource?: ${Okio.buffer(sink) is BufferedSource}")
    }
    public override func beforeEach(): Unit {
    }
    public override func afterEach(): Unit {
        
    }
    // buffer(sink: Sink): BufferedSink 
    // 返回缓冲写入Sink的新Sink。返回的BufferedSink可以将Sink的内存缓冲区进行批量写入。
    @TestCase
    @Bench[1]
    func okio_buffer_Sink_025_1(): Unit {
        Okio.buffer(sink)
    }
    @TestCase
    @Bench[10]
    func okio_buffer_Sink_025_10(): Unit {
        Okio.buffer(sink)
    }
    @TestCase
    @Bench[100]
    func okio_buffer_Sink_025_100(): Unit {
        Okio.buffer(sink)
    }
    @TestCase
    @Bench[1000]
    func okio_buffer_Sink_025_1000(): Unit {
        Okio.buffer(sink)
    }
    @TestCase
    @Bench[10000]
    func okio_buffer_Sink_025_10000(): Unit {
        Okio.buffer(sink)
    }
}