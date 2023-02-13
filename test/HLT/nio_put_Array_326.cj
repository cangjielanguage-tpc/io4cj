// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_put_Array_326 {

    @TestCase
    // 相当于 put(src, 0, src.size)
    func nio_put_Array_326(): Unit {
        
        println("---------------------------nio_put_Array_326-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [0, 0, 0, 238, 238, 238, 238, 239, 1, 1]
        @Assert(byteBuffer.array(),arrR)
    }
    @TestCase
    func nio_put_Array_326_2(): Unit {
        
        println("---------------------------nio_put_Array_326_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.put(src)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

        println("byteBuffer.array() : ${byteBuffer.array()}")
        var arrR :Array<UInt8> = [0, 0, 0]
        @Assert(byteBuffer.array(),arrR)
    }
    @TestCase
    func nio_put_Array_326_4(): Unit {
        
        println("---------------------------nio_put_Array_326_4-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var src :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_put_Array_326_5(): Unit {
        
        println("---------------------------nio_put_Array_326_5-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var src :Array<UInt8> = []
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.put(src)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

        println("src : ${src}")
        var arrR :Array<UInt8> = []
        @Assert(src,arrR)
    }
}