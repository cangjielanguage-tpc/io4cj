// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from okio import nio.ByteBuffer
from std import socket.*

main () {
    //hmacsha512 algorithm
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let HMAC_KEY: String = "test1280"
    let hashingSink: HashingSink = HashingSink.hmacSha512(sink , HMAC_KEY)
    source.writeUtf8("0123456789ABCDEF")
    hashingSink.writehmacSha512(source, 16)
    let a: String = hashingSink.hash()
    if(a !=  "44f986af4ca102bfa133e7135994173e120399078e4fdbf2363c4ac975cc3ff67cbe235c7e3667a6120827118dc3ac8e54c949d7f6fdacc704cdf86b1c13a530") {
        return 1
    }

    //hmacsha256 algorithm
    var source256: Buffer = Buffer()
    var sink256: Buffer = Buffer()
    let HMAC_KEY256: String = "test1280"
    let hashingSink256: HashingSink = HashingSink.hmacSha256(sink256 , HMAC_KEY256)
    source256.writeUtf8("0123456789ABCDEF")
    hashingSink256.writehmacSha256(source256, 16)
    let b: String = hashingSink256.hash()
    if(b !=  "b75ddc670bb8c75296d3207bfa8549df81ba3ef33500593c9d644a03dbcc1e0d") {
        return 1
    }

    //hmacsha1 algorithm
    var source1: Buffer = Buffer()
    var sink1: Buffer = Buffer()
    let HMAC_KEY1: String = "test1280"
    let hashingSink1: HashingSink = HashingSink.hmacSha1(sink1 , HMAC_KEY1)
    source1.writeUtf8("0123456789ABCDEF")
    hashingSink1.writehmacSha1(source1, 16)
    let c: String = hashingSink1.hash()
    if(c !=  "e665c280cf27dacd1f1b6b053cb307f32ee32fd0") {
        return 1
    }
    return 0
}