// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*
import io4cj.*
import std.socket.*

main () {
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let hashingSource: HashingSource = HashingSource.md5(source)
    source.writeUtf8("helloworld")
    let result: Int64 = hashingSource.read(sink, 0x7fffffffffffffff)
    hashingSource.readMD5()
    try{
        let hs1 = hashingSource.isClosed()
    }catch(e: Exception) {
        e.toString()
    }
    let a: String = hashingSource.hash()
    if(result != 10){
        return 2
    }
    if(a != "fc5e038d38a57032085441e7fe7010b0") {
        return 1
    }

    //sha1 algorithm
    var sourcesha1: Buffer = Buffer()
    var sinksha1: Buffer = Buffer()
    let hashingSourcesha1: HashingSource = HashingSource.sha1(sourcesha1)
    sourcesha1.writeUtf8("abc")
    let resultsha1: Int64 = hashingSourcesha1.read(sinksha1, 0x7fffffffffffffff)
    hashingSourcesha1.readSHA1()
    let b: String = hashingSourcesha1.hash()
    if(resultsha1 != 3){
        return 2
    }
    if(b != "a9993e364706816aba3e25717850c26c9cd0d89d") {
        return 1
    }

    //sha256 algorithm
    var sourcesha256: Buffer = Buffer()
    var sinksha256: Buffer = Buffer()
    let hashingSourcesha256: HashingSource = HashingSource.sha256(sourcesha256)
    sourcesha256.writeUtf8("abc")
    let resultsha256: Int64 = hashingSourcesha256.read(sinksha256, 0x7fffffffffffffff)
    hashingSourcesha256.readSHA256()
    let c: String = hashingSourcesha256.hash()
    if(resultsha256 != 3){
        return 2
    }
    if(c != "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad") {
        return 1
    }
   
    return 0
}