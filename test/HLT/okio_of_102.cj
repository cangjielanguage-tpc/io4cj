// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_of_102 {

    @TestCase
    func okio_of_102(): Unit {
        var exc = ""
        // 参数 Int64 - offset 偏移量 > Array<Byte>长度 
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),11,11)

        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
        exc = ""

        // 参数 Int64 - offset 偏移量 < Array<Byte>长度 offset + byteCount > Array<Byte>长度  
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),1,11)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=ello world]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
        exc = ""

        // 参数 Int64 - offset 偏移量 < Array<Byte>长度 offset + byteCount = Array<Byte>长度  
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),1,10)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=ello world]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        exc = ""

        // 参数 Int64 - offset 偏移量 < Array<Byte>长度 offset + byteCount < Array<Byte>长度  
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),2,9)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=llo world]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        exc = ""

        // 参数 Int64 - offset 偏移量 < Array<Byte>长度 (0)
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),0,9)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello wor]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        exc = ""

        // 参数 Int64 - offset 偏移量 < Array<Byte>长度 (-1)
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),-1,9)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello wor]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
        exc = ""

        // 参数 Int64 - offset 偏移量 = Array<Byte>长度 
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),10,1)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=d]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }

        // 参数 Int64 - byteCount 字节长度 > Array<Byte>长度 
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),0,12)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello wor]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
        exc = ""

        // 参数 Int64 - byteCount 字节长度 (0)
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),0,0)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[size=0]")
            
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        exc = ""

        // 参数 Int64 - byteCount 字节长度 (-1)
        try {
            var bs = ByteString.of("hello world".toUtf8Array(),0,-1)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello wor]")
            
        } catch (e:NegativeArraySizeException) {
            // e.printStackTrace()
            println("e.message = \"NegativeArraySizeException\"")
            exc = "NegativeArraySizeException"
        }
        @Assert(exc,"NegativeArraySizeException")
        exc = ""
    }   
}