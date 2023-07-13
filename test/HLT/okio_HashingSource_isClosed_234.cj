// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

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