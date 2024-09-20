// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import io4cj.*

main () {

    //sha1 algorithm
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let HMAC_KEY: String = "test1280"
    let hashingSource: HashingSource = HashingSource.hmacSha1(source , HMAC_KEY)
    source.writeUtf8("0123456789ABCDEF")
    let result: Int64 = hashingSource.read(sink, 0x7fffffffffffffff)
    hashingSource.readhmacSha1()
    let a: String = hashingSource.hash()
    if(result != 16){
        return 2
    }
    if(a != "e665c280cf27dacd1f1b6b053cb307f32ee32fd0") {
        return 1
    }

    //sha256 algorithm
    var source2: Buffer = Buffer()
    var sink2: Buffer = Buffer()
    let HMAC_KEY2: String = "test1280"
    let hashingSource2: HashingSource = HashingSource.hmacSha256(source2 , HMAC_KEY2)
    source2.writeUtf8("0123456789ABCDEF")
    let result2: Int64 = hashingSource2.read(sink2, 0x7fffffffffffffff)
    hashingSource2.readhmacSha256()
    let b: String = hashingSource2.hash()
    if(result2 != 16){
        return 2
    }
    if(b != "b75ddc670bb8c75296d3207bfa8549df81ba3ef33500593c9d644a03dbcc1e0d") {
        return 1
    }
    //hashingSource2.isClosed()
    return 0
}