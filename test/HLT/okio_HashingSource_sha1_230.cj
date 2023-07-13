// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_HashingSource_md5_230{

    @TestCase 
    // 返回一个使用过时的sha1哈希算法生成160位哈希的接收器。
    func okio_HashingSource_md5_230(): Unit {

        println("---------------------------okio_HashingSource_md5_230-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"2aae6c35c94fcfb415dbe95f408b9ce91ee846ed")
    }
    @TestCase 
    func okio_HashingSource_md5_230_2(): Unit {

        println("---------------------------okio_HashingSource_md5_230_2-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"3617b3d66d38049664288366ce2ef9f8b9747883")
    }
    // @TestCase 
    // func okio_HashingSource_md5_230_3(): Unit {

    //     println("---------------------------okio_HashingSource_md5_230_3-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha1(source)
    //     source.writeUtf8("hello world")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA1()
    //     println("hashingSource.readSHA1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_230_4(): Unit {

        println("---------------------------okio_HashingSource_md5_230_4-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 12)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"2aae6c35c94fcfb415dbe95f408b9ce91ee846ed")
    }
    @TestCase 
    func okio_HashingSource_md5_230_5(): Unit {

        println("---------------------------okio_HashingSource_md5_230_5-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 6)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"4c6737b9f54cad3f05434a1b09181a3324eb9815")
    }
    @TestCase 
    func okio_HashingSource_md5_230_6(): Unit {

        println("---------------------------okio_HashingSource_md5_230_6-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"4994bf402e174fd8b5f0f08dd555883f56df3133")
    }
    // @TestCase 
    // func okio_HashingSource_md5_230_7(): Unit {

    //     println("---------------------------okio_HashingSource_md5_230_7-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha1(source)
    //     source.writeUtf8("华为")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA1()
    //     println("hashingSource.readSHA1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_230_8(): Unit {

        println("---------------------------okio_HashingSource_md5_230_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 7)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"4c6737b9f54cad3f05434a1b09181a3324eb9815")
    }
    @TestCase 
    func okio_HashingSource_md5_230_9(): Unit {

        println("---------------------------okio_HashingSource_md5_230_9-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 4)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"c4b5c86bd577da3d93fea7c89cba61c78b48e589")
    }
    @TestCase 
    func okio_HashingSource_md5_230_10(): Unit {

        println("---------------------------okio_HashingSource_md5_230_10-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"c4a2d99bc28d236098a095277b7eb0718d6be068")
    }
    // @TestCase 
    // func okio_HashingSource_md5_230_11(): Unit {

    //     println("---------------------------okio_HashingSource_md5_230_11-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.sha1(source)
    //     source.writeUtf8("0123")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readSHA1()
    //     println("hashingSource.readSHA1() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_230_12(): Unit {

        println("---------------------------okio_HashingSource_md5_230_12-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.sha1(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readSHA1()
        println("hashingSource.readSHA1() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"c4b5c86bd577da3d93fea7c89cba61c78b48e589")
    }
}