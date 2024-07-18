// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSink_isClosed_228{

    @TestCase 
    // 判断资源是否关闭
    func okio_HashingSink_isClosed_228(): Unit {

        println("---------------------------okio_HashingSink_isClosed_228-----------------------------")

        var source: Buffer = Buffer()
        var sink: Sink = Buffer()
        var buffersink = Okio.buffer(sink)
        let hashingSink: HashingSink = HashingSink.hmacSha512(buffersink,"hello world")
        source.writeUtf8("hello world")
        hashingSink.writehmacSha512(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")

        println(hashingSink.isClosed())
        sink.close()
        buffersink.close()
        println(hashingSink.isClosed())

        // @Assert(hashingSink.hash(),"dce414cb1ac4e7d400ebe75f437ba90ada41c339874276b0807b7a8d9d73b56dbde7898e99c4ed92659f30ccd40c712ee517fc229012cffcd798d9ef7e357dd8")
    }
    
}