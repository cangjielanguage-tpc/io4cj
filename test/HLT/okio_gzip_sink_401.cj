// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_gzip_sink_401 {

    @TestCase
    func okio_gzip_sink_401(): Unit {
        let data: Buffer = Buffer()
        let testString: String = "仓颉你好cangjenihaoaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        data.writeUtf8(testString)
        let sink: Buffer = Buffer()
        let gs: GzipSink = GzipSink(sink)
        gs.write(data, data.size)
        var exc = ""
        try{
        gs.flush()
        }catch(e: Exception){
            exc = "Exception"
        }
        @Assert(exc,"")
        println(gs.flush())
        println(sink)
        println(gs.isClosed())
        @Assert(gs.isClosed(),false)
    }

    @TestCase
    func okio_gzip_sink_402(): Unit {
        let data: Buffer = Buffer()
        let testString: String = "Test whether gzipsink can be compressed"
        data.writeUtf8(testString)
        let inflaterSource: InflaterSource = InflaterSource(data)
        
        var exc = ""
        try{
        inflaterSource.timeout()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc,"")

        var exc1 = ""
        try{
        inflaterSource.isClosed()
        }catch(e: Exception){
            exc1 = e.message
        }
        @Assert(exc1,"isClosed not support.")

        var exc2 = ""
        try{
        inflaterSource.close()
        }catch(e: Exception){
            exc2 = e.message
        }
        @Assert(exc2,"")

        println(inflaterSource.close())
        println(inflaterSource.toString())
        @Assert(inflaterSource.toString(),"[size=39] [84, 101, 115, 116, 32, 119, 104, 101, 116, 104, 101, 114, 32, 103, 122, 105, 112, 115, 105, 110, 107, 32, 99, 97, 110, 32, 98, 101, 32, 99, 111, 109, 112, 114, 101, 115, 115, 101, 100]")
    }

    @TestCase
    func okio_gzipsource_1(): Unit { 
        let data: Buffer = Buffer()
        let original: String = "They're moving in herds. They do move in herds."
        data.writeUtf8(original)
        let sink: Buffer = Buffer()
        //var deflater: Deflater = Deflater()
        var deflaterSink: DeflaterSink = DeflaterSink(sink)
        deflaterSink.write(data, data.size)

        var exc1 = ""
        try{
        deflaterSink.isClosed()
        }catch(e: Exception){
            exc1 = e.message
        }
        @Assert(exc1,"isClosed not support.")
        
        let result: Buffer = Buffer()
        let source: GzipSource = GzipSource(sink)
        var exc = ""
        try{
        source.timeout()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc , "")

        var exce = ""
        try{
        source.close() 
        }catch(e: Exception){
            exce = e.message
        }
        @Assert(exce , "")
             
        println(source.toString())
        println(source.isClosed())
        @Assert(source.toString(),"RealBufferedSource: [size=0] []")
        @Assert(source.isClosed(),true)
    }

}
