// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_HashingSink_hmacSha256_226{

    @TestCase 
    // 返回一个使用SHA-256 HMAC算法生成256位哈希的接收器。 
    func okio_HashingSink_hmacSha256_226(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"hello world")
        source.writeUtf8("hello world")
        hashingSink.writehmacSha256(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"6ec035d91dc104db569a01a4d8c16fb13f125dc298992edfb8e66d3a837fe0c5")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_2(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha256(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_3(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha256(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_4(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_4-----------------------------")

        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha256(source, 6)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_5(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha256(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_6(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha256(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_7(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha256(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"634bb7cd766b8d3f3ae8450ca94fde3e21a047509a9e9dc21d8c9b304f037395")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_8(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha256(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_9(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"0123")
            source.writeUtf8("0123")
            hashingSink.writehmacSha256(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_10(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha256(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The key cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha256_226_11(): Unit {

        println("---------------------------okio_HashingSink_hmacSha256_226_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha256(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha256(source, 1)
        } catch (e :Exception){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("The key cannot be empty."),true)
    }
}