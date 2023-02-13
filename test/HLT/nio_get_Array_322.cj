// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*
from okio import nio.*

@Test
public class nio_get_Array_322{

    @TestCase
    // 将此缓冲区的字节传输到给定的目标数组中。
    // 如果此缓冲中剩余的字节少于满足请求所需的字节（即如果 length > remaining()），则不传输字节且抛出Exception。
    func nio_get_Array_322(): Unit {
        
        println("---------------------------nio_get_Array_322-----------------------------")

        var arr :Array<UInt8> = [238, 238, 238, 238, 238, 238, 238, 239, 1, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,9)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=9 cap=10]")

        println("dst : ${dst}")
        @Assert(dst,Array<UInt8>(3,item:238))
    }
    @TestCase
    func nio_get_Array_322_2(): Unit {
        
        println("---------------------------nio_get_Array_322_2-----------------------------")

        var arr :Array<UInt8> = [238, 238, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,3)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=3 lim=3 cap=3]")

        println("dst : ${dst}")
        @Assert(dst,arr)
    }
    @TestCase
    func nio_get_Array_322_3(): Unit {
        
        println("---------------------------nio_get_Array_322_3-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst,0,2)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=2 lim=2 cap=2]")

        println("dst : ${dst}")
        var arrR :Array<UInt8> = [238, 1, 0]
        @Assert(dst,arrR)
    }
    @TestCase
    func nio_get_Array_322_4(): Unit {
        
        println("---------------------------nio_get_Array_322_4-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,0,3)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_get_Array_322_5(): Unit {
        
        println("---------------------------nio_get_Array_322_5-----------------------------")

        var arr :Array<UInt8> = [238, 1]
        var dst :Array<UInt8> = []
        var byteBuffer = ByteBuffer.wrap(arr,0,2)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,0,0)}")
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
    @TestCase
    func nio_get_Array_322_6(): Unit {
        
        println("---------------------------nio_get_Array_322_6-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,0,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_get_Array_322_7(): Unit {
        
        println("---------------------------nio_get_Array_322_7-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst,2,1)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=1 lim=4 cap=4]")

        println("dst : ${dst}")
        var arrR :Array<UInt8> = [0, 0, 238]
        @Assert(dst,arrR)
    }
    @TestCase
    func nio_get_Array_322_8(): Unit {
        
        println("---------------------------nio_get_Array_322_8-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer() : ${byteBuffer.get(dst,2,0)}")
        @Assert(byteBuffer.toString(),"ByteBuffer: [offset=0 mark=-1 pos=0 lim=4 cap=4]")

        println("dst : ${dst}")
        var arrR :Array<UInt8> = [0, 0, 0]
        @Assert(dst,arrR)
    }
    @TestCase
    func nio_get_Array_322_9(): Unit {
        
        println("---------------------------nio_get_Array_322_9-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,-1,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_get_Array_322_10(): Unit {
        
        println("---------------------------nio_get_Array_322_10-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,1,-1)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase
    func nio_get_Array_322_11(): Unit {
        
        println("---------------------------nio_get_Array_322_11-----------------------------")

        var arr :Array<UInt8> = [238, 1, 238, 0]
        var dst :Array<UInt8> = [0, 0, 0]
        var byteBuffer = ByteBuffer.wrap(arr,0,4)
        println("array() : ${byteBuffer.array()}")
        var exc = ""
        try{
            println("byteBuffer() : ${byteBuffer.get(dst,1,4)}")
        } catch (e: Exception){
            // e.printStackTrace()
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }

}