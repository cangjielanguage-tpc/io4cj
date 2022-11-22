// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from okio import nio.ByteBuffer
from std import socket.*

main () {
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let hashingSink: HashingSink = HashingSink.md5(sink)
    source.writeUtf8("helloworld")
    hashingSink.writeMD5(source, 10)
    let a: String = hashingSink.hash()
    if(a != "fc5e038d38a57032085441e7fe7010b0") {
        return -1
    }

    //sha1 algorithm
    var sourcesha1: Buffer = Buffer()
    var sinksha1: Buffer = Buffer()
    let hasha1: HashingSink = HashingSink.sha1(sinksha1)
    sourcesha1.writeUtf8("abc")
    hasha1.writeSHA1(sourcesha1, 3)
    let b: String = hasha1.hash()
    if(b != "a9993e364706816aba3e25717850c26c9cd0d89d") {
        return -1
    }

    //sha256 algorithm
    var sourcesha256: Buffer = Buffer()
    var sinksha256: Buffer = Buffer()
    let hasha256: HashingSink = HashingSink.sha256(sinksha256)
    sourcesha256.writeUtf8("abc")
    hasha256.writeSHA256(sourcesha256, 3)
    let c: String = hasha256.hash()
    if(c != "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad") {
        return -1
    }

    //sha512 algorithm
    var sourcesha512: Buffer = Buffer()
    var sinksha512: Buffer = Buffer()
    let hasha512: HashingSink = HashingSink.sha512(sinksha512)
    sourcesha512.writeUtf8("abc")
    hasha512.writeSHA512(sourcesha512, 3)
    let d: String = hasha512.hash()
    if(d != "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f") {
        return -1
    }
    //hasha512.isClosed()

    return 0
}