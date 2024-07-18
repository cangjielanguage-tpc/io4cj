// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

@Test
public class okio_HashingSink_md5_221{

    @TestCase 
    // 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
    func okio_HashingSink_md5_221(): Unit {

        println("---------------------------okio_HashingSink_md5_221-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.md5(sink)
        source.writeUtf8("hello world")
        hashingSink.writeMD5(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"5eb63bbbe01eeed093cb22bb8f5acdc3")
    }
    @TestCase 
    func okio_HashingSink_md5_221_2(): Unit {

        println("---------------------------okio_HashingSink_md5_221_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("hello world")
            hashingSink.writeMD5(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_md5_221_3(): Unit {

        println("---------------------------okio_HashingSink_md5_221_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("hello world")
            hashingSink.writeMD5(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_md5_221_4(): Unit {

        println("---------------------------okio_HashingSink_md5_221_4-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("华为")
            hashingSink.writeMD5(source, 6)
            // println("source.readByteArray() ${source.readByteArray()}")
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_md5_221_5(): Unit {

        println("---------------------------okio_HashingSink_md5_221_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("华为")
            hashingSink.writeMD5(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_md5_221_6(): Unit {

        println("---------------------------okio_HashingSink_md5_221_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("华为")
            hashingSink.writeMD5(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_md5_221_7(): Unit {

        println("---------------------------okio_HashingSink_md5_221_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.md5(sink)
        source.writeUtf8("0123")
        hashingSink.writeMD5(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"eb62f6b9306db575c2d596b1279627a4")
    }
    @TestCase 
    func okio_HashingSink_md5_221_8(): Unit {

        println("---------------------------okio_HashingSink_md5_221_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.md5(sink)
        source.writeUtf8("0123")
        hashingSink.writeMD5(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_md5_221_9(): Unit {

        println("---------------------------okio_HashingSink_md5_221_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("0123")
            hashingSink.writeMD5(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_md5_221_10(): Unit {

        println("---------------------------okio_HashingSink_md5_221_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("")
            hashingSink.writeMD5(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_md5_221_11(): Unit {

        println("---------------------------okio_HashingSink_md5_221_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.md5(sink)
            source.writeUtf8("")
            hashingSink.writeMD5(source, 1)
        } catch (e:Exception){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}