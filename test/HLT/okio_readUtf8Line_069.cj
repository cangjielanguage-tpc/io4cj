// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_readUtf8Line_069{

    @TestCase
    func okio_readUtf8Line_069(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n中国")
        @Assert(a_buffer.toString(),"[size=13] [229, 141, 142, 228, 184, 186, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.readUtf8Line().getOrThrow(),"华为")
        @Assert(a_buffer.size,6)
        @Assert(a_buffer.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.exhausted(),false)

        let a_buffer2 = Buffer()
        a_buffer2.writeUtf8("华为\r\n中国")
        @Assert(a_buffer2.toString(),"[size=14] [229, 141, 142, 228, 184, 186, 13, 10, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.readUtf8Line().getOrThrow(),"华为")
        @Assert(a_buffer2.size,6)
        @Assert(a_buffer2.toString(),"[size=6] [228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer2.exhausted(),false)
    }
    @TestCase
    func okio_readUtf8Line_069_2(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为\n中国")
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8Line().getOrThrow(),"华为")
        @Assert(bufferedSource.exhausted(),false)

        let a_buffer2 = Buffer()
        a_buffer2.writeUtf8("华为\r\n中国")
        let source2: Source = a_buffer2
        let bufferedSource2: BufferedSource = Okio.buffer(source2)
        @Assert(bufferedSource2.readUtf8Line().getOrThrow(),"华为")
        @Assert(bufferedSource2.exhausted(),false)

        var exc = ""
        try{
            a_buffer.writeUtf8("华为\n中国")
            bufferedSource.close()
            bufferedSource.readUtf8Line()
        } catch (e:Exception){
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc.contains("closed"),true)
    }
    @TestCase
    func okio_readUtf8Line_069_3(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为中国")
        @Assert(a_buffer.toString(),"[size=12] [229, 141, 142, 228, 184, 186, 228, 184, 173, 229, 155, 189]")
        @Assert(a_buffer.readUtf8Line().getOrThrow(),"华为中国")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.toString(),"[size=0] []")
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readUtf8Line_069_4(): Unit {
        let a_buffer = Buffer()
        a_buffer.writeUtf8("华为中国")
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readUtf8Line().getOrThrow(),"华为中国")
        @Assert(bufferedSource.exhausted(),true)
    }
    
}