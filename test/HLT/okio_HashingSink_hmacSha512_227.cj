// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_HashingSink_hmacSha512_227{

    @TestCase 
    // 返回一个使用SHA-512 HMAC算法生成512位哈希的接收器。 
    func okio_HashingSink_hmacSha512_227(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"hello world")
        source.writeUtf8("hello world")
        hashingSink.writehmacSha512(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"dce414cb1ac4e7d400ebe75f437ba90ada41c339874276b0807b7a8d9d73b56dbde7898e99c4ed92659f30ccd40c712ee517fc229012cffcd798d9ef7e357dd8")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_2(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha512(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_3(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"hello world")
            source.writeUtf8("hello world")
            hashingSink.writehmacSha512(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_4(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_4-----------------------------")

        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha512(source, 6)
            // println("source.readByteArray() ${source.readByteArray()}")
            println("hashingSink.hash() = ${hashingSink.hash()}")
            @Assert(hashingSink.hash(),"60eb91e8dd9359402a65c1832d84fbb1c4a8228de52d4566ac36cd8139c829d331cf057d14e9f5a9345f24b3840ab29e7a7d67ce8bcceb2edce13e7bce21ccd8")
    
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_5(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha512(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_6(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"华为")
            source.writeUtf8("华为")
            hashingSink.writehmacSha512(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_7(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha512(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"a292d44245ad4b8df4ff02b0f864e685332f86780c335c430af88cb92ea921ec165ba57d63014f12266dae61a8b0f825af9e65108bc6e6b428b6c760b4074fe3")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_8(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"0123")
        source.writeUtf8("0123")
        hashingSink.writehmacSha512(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_9(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"0123")
            source.writeUtf8("0123")
            hashingSink.writehmacSha512(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_10(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_10-----------------------------")
        var exc=""
        try{
           var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha512(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The key cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_hmacSha512_227_11(): Unit {

        println("---------------------------okio_HashingSink_hmacSha512_227_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.hmacSha512(sink,"")
            source.writeUtf8("")
            hashingSink.writehmacSha512(source, 1)
        } catch (e :Exception){
            exc = e.message
            println(e.message)
        }
        @Assert(exc,"The key cannot be empty.")
        
    }
}