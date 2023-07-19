// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_HashingSource_hmacSha1_232{

    @TestCase 
    // 返回一个使用SHA-1 HMAC算法生成160位哈希的接收器。 
    func okio_HashingSource_hmacSha1_232(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"06890f022f2ec5df84589713e90242d9290e4850")
    }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_2(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_2-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"98c697eff28583e84a8c2bbbf6545708da126a0a")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha1_232_3(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha1_232_3-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha1(source,"hello world")
    //     source.writeUtf8("hello world")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha1()
    //     println("hashingSource.readhmacSha1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_4(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_4-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"hello world")
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 12)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"06890f022f2ec5df84589713e90242d9290e4850")
    }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_5(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_5-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 6)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"3621b977802ecdbaef2d9b4697227533c7ac36ae")
    }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_6(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_6-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"79aacf203efa4d72d3e8d79f39ef199c78885bd4")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha1_232_7(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha1_232_7-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha1(source,"华为")
    //     source.writeUtf8("华为")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha1()
    //     println("hashingSource.readhmacSha1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_8(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"华为")
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 7)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"3621b977802ecdbaef2d9b4697227533c7ac36ae")
    }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_9(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_9-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 4)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"82c0932038922b4ff96ec6a435ee914c1d8ef3f7")
    }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_10(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_10-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"72a30522084fc28a2af13583c59cfae60cf0b1cc")
    }
    // @TestCase 
    // func okio_HashingSource_hmacSha1_232_11(): Unit {

    //     println("---------------------------okio_HashingSource_hmacSha1_232_11-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.hmacSha1(source,"0123")
    //     source.writeUtf8("0123")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readhmacSha1()
    //     println("hashingSource.readhmacSha1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_hmacSha1_232_12(): Unit {

        println("---------------------------okio_HashingSource_hmacSha1_232_12-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.hmacSha1(source,"0123")
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readhmacSha1()
        println("hashingSource.readhmacSha1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"82c0932038922b4ff96ec6a435ee914c1d8ef3f7")
    }
}