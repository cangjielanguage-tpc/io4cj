// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

@Test
public class okio_HashingSink_sha256_223{

    @TestCase 
    // 返回一个使用过时的sha256哈希算法生成256位哈希的接收器。
    func okio_HashingSink_sha256_223(): Unit {

        println("---------------------------okio_HashingSink_sha256_223-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha256(sink)
        source.writeUtf8("hello world")
        hashingSink.writeSHA256(source, 11)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_2(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_2-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA256(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_3(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_3-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("hello world")
            hashingSink.writeSHA256(source, 12)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha256_223_4(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_4-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA256(source, 6)
            // println("source.readByteArray() ${source.readByteArray()}")
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_5(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_5-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA256(source, 3)
            println("hashingSink.hash() = ${hashingSink.hash()}")
            // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
        } catch (e:IndexOutOfBoundsException){
            exc="IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_6(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_6-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("华为")
            hashingSink.writeSHA256(source, 7)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha256_223_7(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_7-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha256(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA256(source, 4)
        // println("source.readByteArray() ${source.readByteArray()}")
        println("hashingSink.hash() = ${hashingSink.hash()}")
        @Assert(hashingSink.hash(),"1be2e452b46d7a0d9656bbb1f768e8248eba1b75baed65f5d99eafa948899a6a")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_8(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_8-----------------------------")

        var source: Buffer = Buffer()
        var sink: Buffer = Buffer()
        let hashingSink: HashingSink = HashingSink.sha256(sink)
        source.writeUtf8("0123")
        hashingSink.writeSHA256(source, 3)
        println("hashingSink.hash() = ${hashingSink.hash()}")
        // @Assert(hashingSink.hash(),"d63e7ea059dc68e97e2ef16531e47e6c")
    }
    @TestCase 
    func okio_HashingSink_sha256_223_9(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_9-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("0123")
            hashingSink.writeSHA256(source, 5)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
    @TestCase 
    func okio_HashingSink_sha256_223_10(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_10-----------------------------")
        var exc=""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("")
            hashingSink.writeSHA256(source, 0)
            println("hashingSink.hash() = ${hashingSink.hash()}")
        } catch (e:Exception){
            exc=e.message
        }
        @Assert(exc,"The data cannot be empty.")
        
    }
    @TestCase 
    func okio_HashingSink_sha256_223_11(): Unit {

        println("---------------------------okio_HashingSink_sha256_223_11-----------------------------")
        var exc = ""
        try{
            var source: Buffer = Buffer()
            var sink: Buffer = Buffer()
            let hashingSink: HashingSink = HashingSink.sha256(sink)
            source.writeUtf8("")
            hashingSink.writeSHA256(source, 1)
        } catch (e :ArrayIndexOutOfBoundsException){
            exc = e.message
            println(e.message)
        }
        @Assert(exc.contains("ArrayIndexOutOfBoundsException"),true)
    }
}