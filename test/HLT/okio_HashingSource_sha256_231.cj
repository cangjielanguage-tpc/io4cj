// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_HashingSource_sha256_231{

    @TestCase 
    // 返回一个使用过时的sha256哈希算法生成256位哈希的接收器。
    func okio_HashingSource_sha256_231(): Unit {

        println("---------------------------okio_HashingSource_sha256_231-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9")
    }
    @TestCase 
    func okio_HashingSource_sha256_231_2(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_2-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"d6a81f224bbf2f7c22baddbd5d40730eb20cfb0b3d74e10cab61788214caceb1")
    }
    // @TestCase 
    // func okio_HashingSource_sha256_231_3(): Unit {

    //     println("---------------------------okio_HashingSource_sha256_231_3-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha256(source)
    //     source.writeUtf8("hello world")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA256()
    //     println("hashingSource.readSHA256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_sha256_231_4(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_4-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 12)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9")
    }
    @TestCase 
    func okio_HashingSource_sha256_231_5(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_5-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 6)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"82eaaba81d9dcc54deabafe357f46f8668bd9bf13a30f319fb0a6d7874592295")
    }
    @TestCase 
    func okio_HashingSource_sha256_231_6(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_6-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"4d26eba1d6d8cedb67b4040383f872dce69e2edffd43efcc4757b2b25099601c")
    }
    // @TestCase 
    // func okio_HashingSource_sha256_231_7(): Unit {

    //     println("---------------------------okio_HashingSource_sha256_231_7-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha256(source)
    //     source.writeUtf8("华为")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA256()
    //     println("hashingSource.readSHA256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_sha256_231_8(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 7)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"82eaaba81d9dcc54deabafe357f46f8668bd9bf13a30f319fb0a6d7874592295")
    }
    @TestCase 
    func okio_HashingSource_sha256_231_9(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_9-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 4)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a")
    }
    @TestCase 
    func okio_HashingSource_sha256_231_10(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_10-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"bf6aaaab7c143ca12ae448c69fb72bb4cf1b29154b9086a927a0a91ae334cdf7")
    }
    // @TestCase 
    // func okio_HashingSource_sha256_231_11(): Unit {

    //     println("---------------------------okio_HashingSource_sha256_231_11-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha256(source)
    //     source.writeUtf8("0123")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA256()
    //     println("hashingSource.readSHA256() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_sha256_231_12(): Unit {

        println("---------------------------okio_HashingSource_sha256_231_12-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha256(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readSHA256()
        println("hashingSource.readSHA256() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a")
    }
}