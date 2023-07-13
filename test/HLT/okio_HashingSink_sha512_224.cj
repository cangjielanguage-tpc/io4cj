// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_HashingSink_sha512_224{

    @TestCase 
    // 返回一个使用过时的sha512哈希算法生成256位哈希的接收器。
    func okio_HashingSink_sha512_224(): Unit {

        println("---------------------------okio_HashingSink_sha512_224-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha512(sink)
        source.writeUtf8("hello world")
        hashingSink.writeSHA512(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_2(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA512(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_3(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA512(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha512_224_4(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_4-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA512(source, 6)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_5(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA512(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_6(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA512(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha512_224_7(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha512(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA512(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"26e5556d35bebab660c17eaf2ffebb823ddfb4b009a6e1f687e95fdf40ee637040fe258bb737d537c5d04d2558f2d2e802b2ef492944330f0b8e4bb17222e1d5")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_8(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha512(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA512(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_9(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("0123")
            hashingSink.writeSHA512(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha512_224_10(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("")
            hashingSink.writeSHA512(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_sha512_224_11(): Unit {

        println("---------------------------okio_HashingSink_sha512_224_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha512(sink)
            source.writeUtf8("")
            hashingSink.writeSHA512(source, 1)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}