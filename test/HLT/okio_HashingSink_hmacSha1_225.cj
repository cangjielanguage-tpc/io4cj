// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSink_hmacSha1_225{

    @TestCase 
    // 返回一个使用SHA-1 HMAC算法生成160位哈希的接收器。
    func okio_HashingSink_hmacSha1_225(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"hello world")
        source.writeUtf8("hello world")
        hashingSink.writehmacSha1(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"06890f022f2ec5df84589713e90242d9290e4850")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_2(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha1(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_3(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha1(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_4(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_4-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha1(source, 6)
            // println("source.readByteArray() ${source.readByteArray()}")
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_5(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha1(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_6(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha1(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_7(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha1(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"82c0932038922b4ff96ec6a435ee914c1d8ef3f7")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_8(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha1(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_9(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"0123")
            source.writeUtf8("0123")
            hashingSink.writehmacSha1(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_10(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha1(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The key cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha1_225_11(): Unit {

        println("---------------------------okio_HashingSink_hmacSha1_225_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha1(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha1(source, 1)
        } catch (e :Exception){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("The key cannot be empty."),true)
    }
}