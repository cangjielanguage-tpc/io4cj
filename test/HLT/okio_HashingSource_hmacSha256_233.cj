// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_HashingSource_hmacSha256_233{

    @TestCase 
    // 返回一个使用SHA-256 HMAC算法生成256位哈希的接收器。
    func okio_HashingSource_hmacSha256_233(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"6ec035d91dc104db569a01a4d8c16fb13f125dc298992edfb8e66d3a837fe0c5")
    }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_2(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_2-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"f632dd3f7a9f17d75d18023ad931c1be1cb36f3caf376e32e200d4b2191370cb")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha256_233_3(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha256_233_3-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha256(source,"hello world")
    //     source.writeUtf8("hello world")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha256()
    //     println("hashingSource.readhmacSha256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_4(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_4-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 12)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"6ec035d91dc104db569a01a4d8c16fb13f125dc298992edfb8e66d3a837fe0c5")
    }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_5(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_5-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 6)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"3572ed4a22416aacd4ceca5eea9473552113791c8f86ace4b3a2702a365d21e0")
    }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_6(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_6-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"cefc3f0eead4ef2d681c585755979d8f496f0b26240842419e85bc06f59b64a4")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha256_233_7(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha256_233_7-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha256(source,"华为")
    //     source.writeUtf8("华为")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha256()
    //     println("hashingSource.readhmacSha256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_8(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 7)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"3572ed4a22416aacd4ceca5eea9473552113791c8f86ace4b3a2702a365d21e0")
    }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_9(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_9-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 4)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"634bb7cd766b8d3f3ae8450ca94fde3e21a047509a9e9dc21d8c9b304f037395")
    }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_10(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_10-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"0d0fd4255902a5d8a2fd47955921cac0a970732dbc75c03a484e5591496efe8f")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha256_233_11(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha256_233_11-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha256(source,"0123")
    //     source.writeUtf8("0123")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha256()
    //     println("hashingSource.readhmacSha256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha256_233_12(): Unit {

        println("---------------------------okio_HashingSource_hmacSha256_233_12-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha256(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readhmacSha256()
        println("hashingSource.readhmacSha256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"634bb7cd766b8d3f3ae8450ca94fde3e21a047509a9e9dc21d8c9b304f037395")
    }
}