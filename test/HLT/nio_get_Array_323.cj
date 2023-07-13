// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_get_Array_323{

    @TestCase
    // 相当于 get(dst, 0, dst.size)
    func nio_get_Array_323(): Unit {
        
        println("---------------------------nio_get_Array_323-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

        println("dst : ${dst}")
        @Assert(dst,Array<UInt8>(3,item:238))
    }
    @TestCase
    func nio_get_Array_323_2(): Unit {
        
        println("---------------------------nio_get_Array_323_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

        println("dst : ${dst}")
        @Assert(dst,arr)
    }
    @TestCase
    func nio_get_Array_323_4(): Unit {
        
        println("---------------------------nio_get_Array_323_4-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_get_Array_323_5(): Unit {
        
        println("---------------------------nio_get_Array_323_5-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var dst :Array<UInt8> = []
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"")

        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=2 cap=2]")

        println("dst : ${dst}")
        var arrR :Array<UInt8> = []
        @Assert(dst,arrR)
    }
}