// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSource_isClosed_234{

    @TestCase 
    // 判断资源是否关闭
    func okio_HashingSource_isClosed_234(): Unit {

        println("---------------------------okio_HashingSource_isClosed_234-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        var buffersource = Okio.buffer((source as Source).getOrThrow())
        let hashingSource: HashingSource = HashingSource.hmacSha256(buffersource,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")

        println(hashingSource.isClosed())
        sink.close()
        buffersource.close()
        println(hashingSource.isClosed())
    }
}