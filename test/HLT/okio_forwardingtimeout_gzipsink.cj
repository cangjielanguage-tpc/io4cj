// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_ForwardingTimeout {
    @TestCase
    func okio_Forwardingtimeout01(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "It's a UNIX system! I know this!"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout51(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "I"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout52(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "123456789"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout53(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "仓颉你好"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout54(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "仓颉你好cangjenihaoaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout55(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "仓颉你好cangjenihaoaaaaaaaaaaaaaaaaaaaaaaaaaaaa12346789741852963"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout56(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = 
            "仓颉你好cangjenihaoaaaaaaaaaaaaaaaaaaaaaaaaaaaa12346789741852963@#&*》》》》：、、、、、、、"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        gs.close()
        println(gs.toString())
        println(gs.isClosed())
        @Assert(gs.toString(),"RealBufferedSink: [size=0] []")
        @Assert(gs.isClosed(),true)
        var inflated = gunzip(sink)
        @Assert(testString,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout02(): Unit { 
        let data: Buffer = Buffer()
        let original: String = "They're moving in herds. They do move in herds."
        data.writeUtf8(original)
        let sink: Buffer = Buffer()
        //var deflater: Deflater = Deflater()
        var deflaterSink: DeflaterSink = DeflaterSink(sink)
        println(sink.size)
        deflaterSink.write(data, data.size)
        println(sink.size)
        var inflated = gunzip(sink)
        @Assert(original,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout21(): Unit { 
        let data: Buffer = Buffer()
        let original: String = 
            "仓颉你好cangjenihaoaaaaaaaaaaaaaaaaaaaaaaaaaaaa12346789741852963@#&*》》》》：、、、、、、、"
        data.writeUtf8(original)
        let sink: Buffer = Buffer()
        var deflaterSink: DeflaterSink = DeflaterSink(sink)
        println(sink.size)
        deflaterSink.write(data, data.size)
        println(sink.size)
        var inflated = gunzip(sink)
        @Assert(original,inflated.readUtf8())
    }

    @TestCase
    func okio_Forwardingtimeout03(): Unit { 
        let inflated: Buffer = Buffer()
        let aaa: Array<UInt8> = [243, 44, 81, 47, 86, 72, 84, 8, 245, 243, 140, 80, 40, 174, 44, 46, 73, 205, 85, 84,
        240, 84, 200, 206, 203, 47, 87, 40, 201, 200, 44, 86, 4, 0, 81, 47, 86, 72, 84, 8, 245, 243, 140, 80, 40, 174,
        44, 46, 73, 205, 85, 84, 240, 84, 200, 206, 203, 47, 87, 40, 201, 200, 44, 86, 4, 0, 81, 47, 86, 72, 84, 8, 245,
        243, 140, 80, 40, 174, 44, 46, 73, 205, 85, 84, 240, 84, 200, 206, 203, 47, 87, 40, 201, 200, 44, 86]
        let ssss: Buffer = Buffer()
        ssss.write(aaa)
        let source: InflaterSource = InflaterSource(ssss)
        var source1 = source.read(inflated, 1)
        source.close()
        @Assert(inflated.readUtf8(),"I")
    }

    @TestCase
    func okio_Forwardingtimeout04(): Unit { 
        let data: Buffer = Buffer()
        let testString: String = "It's a UNIX system! I know this!"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)

        //println(sink.size) 
        gs.write(data, data.size)
        gs.close()
        var sss = gs.timeout()
        let ft: ForwardingTimeout = ForwardingTimeout(sss)
        println(ft.timeoutNanos())
        println(ft.hasDeadline())
    }

}


public func gunzip(a: Buffer): Buffer {
    let result: Buffer = Buffer()
    let source: GzipSource = GzipSource(a)
    while (source.read(result, 0x7fffffff) != -1) {}
    return result
}
