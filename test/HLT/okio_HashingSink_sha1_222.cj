// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSink_sha1_222{

    @TestCase 
    // 返回一个使用过时的sha1哈希算法生成160位哈希的接收器。
    func okio_HashingSink_sha1_222(): Unit {

        println("---------------------------okio_HashingSink_sha1_222-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha1(sink)
        source.writeUtf8("hello world")
        hashingSink.writeSHA1(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"2aae6c35c94fcfb415dbe95f408b9ce91ee846ed")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_2(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_2-----------------------------")

        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA1(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_3(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA1(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha1_222_4(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_4-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA1(source, 6)
            // println("source.readByteArray() ${source.readByteArray()}")
            println("hashingSink.hash() = ${hashingSink.hash()}")
            @Assert(hashingSink.hash(),"4c6737b9f54cad3f05434a1b09181a3324eb9815")  
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_5(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA1(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_6(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA1(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha1_222_7(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha1(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA1(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"c4b5c86bd577da3d93fea7c89cba61c78b48e589")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_8(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha1(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA1(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_9(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("0123")
            hashingSink.writeSHA1(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha1_222_10(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("")
            hashingSink.writeSHA1(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_sha1_222_11(): Unit {

        println("---------------------------okio_HashingSink_sha1_222_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha1(sink)
            source.writeUtf8("")
            hashingSink.writeSHA1(source, 1)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}