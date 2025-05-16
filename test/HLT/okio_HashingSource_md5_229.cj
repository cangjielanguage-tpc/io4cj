// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSource_md5_229{

    @TestCase 
    // 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
    func okio_HashingSource_md5_229(): Unit {

        println("---------------------------okio_HashingSource_md5_229-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 11)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"5eb63bbbe01eeed093cb22bb8f5acdc3")
    }
    @TestCase 
    func okio_HashingSource_md5_229_2(): Unit {

        println("---------------------------okio_HashingSource_md5_229_2-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(5))
        @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    }
    // @TestCase 
    // func okio_HashingSource_md5_229_3(): Unit {

    //     println("---------------------------okio_HashingSource_md5_229_3-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.md5(source)
    //     source.writeUtf8("hello world")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readMD5()
    //     println("hashingSource.read() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_229_4(): Unit {

        println("---------------------------okio_HashingSource_md5_229_4-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("hello world")
        let num: Int64 = hashingSource.read(sink, 12)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(11))
        @Assert(hashingSource.hash(),"5eb63bbbe01eeed093cb22bb8f5acdc3")
    }
    @TestCase 
    func okio_HashingSource_md5_229_5(): Unit {

        println("---------------------------okio_HashingSource_md5_229_5-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 6)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSource_md5_229_6(): Unit {

        println("---------------------------okio_HashingSource_md5_229_6-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"9a0470878e6bdf5eced349d04a01989a")
    }
    // @TestCase 
    // func okio_HashingSource_md5_229_7(): Unit {

    //     println("---------------------------okio_HashingSource_md5_229_7-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.md5(source)
    //     source.writeUtf8("华为")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readMD5()
    //     println("hashingSource.read() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_229_8(): Unit {

        println("---------------------------okio_HashingSource_md5_229_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("华为")
        let num: Int64 = hashingSource.read(sink, 7)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(6))
        @Assert(hashingSource.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSource_md5_229_9(): Unit {

        println("---------------------------okio_HashingSource_md5_229_9-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 4)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"eb62f6b9306db575c2d596b1279627a4")
    }
    @TestCase 
    func okio_HashingSource_md5_229_10(): Unit {

        println("---------------------------okio_HashingSource_md5_229_10-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 3)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(3))
        @Assert(hashingSource.hash(),"d2490f048dc3b77a457e3e450ab4eb38")
    }
    // @TestCase 
    // func okio_HashingSource_md5_229_11(): Unit {

    //     println("---------------------------okio_HashingSource_md5_229_11-----------------------------")

    //     var source: Buffer = Buffer()
    //     var sink: Buffer = Buffer()
    //     let hashingSource: HashingSource = HashingSource.md5(source)
    //     source.writeUtf8("0123")
    //     let num: Int64 = hashingSource.read(sink, 0)
    //     hashingSource.readMD5()
    //     println("hashingSource.read() = ${num}")
    //     println("hashingSource.hash() = ${hashingSource.hash()}")
    //     @Assert(num,Int64(0))
    //     @Assert(hashingSource.hash(),"5d41402abc4b2a76b9719d911017c592")
    // }
    @TestCase 
    func okio_HashingSource_md5_229_12(): Unit {

        println("---------------------------okio_HashingSource_md5_229_12-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSource: HashingSource = HashingSource.md5(source)
        source.writeUtf8("0123")
        let num: Int64 = hashingSource.read(sink, 5)
        hashingSource.readMD5()
        println("hashingSource.read() = ${num}")
        println("hashingSource.hash() = ${hashingSource.hash()}")
        @Assert(num,Int64(4))
        @Assert(hashingSource.hash(),"eb62f6b9306db575c2d596b1279627a4")
    }
}