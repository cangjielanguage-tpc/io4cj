// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*
from io4cj import nio.*

@Test
public class nio_slice_341 {

    @TestCase
    // 实现此缓冲区的数组返回新的字节缓冲区, 其内容是此缓冲区内容的共享子序列。
    // 新缓冲区的内容将从该缓冲区中的位置索引开始，并包含长度元素。
    // 对该缓冲区内容的更改将在新缓冲区中可见，反之亦然；两个缓冲区的位置、限制和标记值将是独立的。
    func nio_slice_341(): Unit {
        
        println("---------------------------nio_slice_341-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(0,item:0),0,0)
        println("array() : ${byteBuffer.array()}")

        println("byteBuffer.slice() : ${byteBuffer.slice(0,0)}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer.slice(0,0)}","${byteBuffer}")
        // @Assert(byteBuffer.slice(),byteBuffer)
    }
    @TestCase
    func nio_slice_341_2(): Unit {
        
        println("---------------------------nio_slice_341_2-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        println("byteBuffer.slice() : ${byteBuffer.slice(0,5)}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer.slice(0,5)}","${byteBuffer}")
        // @Assert(byteBuffer.slice(),byteBuffer)

    }
    @TestCase
    func nio_slice_341_3(): Unit {
        
        println("---------------------------nio_slice_341_3-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        var byteBuffer1 = byteBuffer.slice(0,3)
    
        println("byteBuffer.slice() : ${byteBuffer1}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer1}","ByteBuffer: [offset=0 mark=-1 pos=0 lim=3 cap=3]")

        byteBuffer.put(123)

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
        @Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

        println("byteBuffer : ${byteBuffer}")
        // @Assert("${byteBuffer}","ByteBuffer: [offset=0 pos=1 lim=3 cap=5]")
        
        println("byteBuffer.slice() : ${byteBuffer1}")
        // @Assert("${byteBuffer1}","ByteBuffer: [offset=0 pos=0 lim=3 cap=5]")

    }
    @TestCase //isDirect isReadOnl接口删除 用例暂时注释
    func nio_slice_341_4(): Unit {
        
        println("---------------------------nio_slice_341_4-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,3)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))

        var byteBuffer1 = byteBuffer.slice()

        // println("byteBuffer.isDirect() : ${byteBuffer.isDirect()}")
        // println("byteBuffer1.isDirect() : ${byteBuffer1.isDirect()}")
        // @Assert(byteBuffer.isDirect(),byteBuffer1.isDirect())

        // println("byteBuffer.isReadOnly() : ${byteBuffer.isReadOnly()}")
        // println("byteBuffer1.isReadOnly() : ${byteBuffer1.isReadOnly()}")
        // @Assert(byteBuffer.isReadOnly(),byteBuffer1.isReadOnly())
    
        println("byteBuffer.slice() : ${byteBuffer1}")
        println("byteBuffer : ${byteBuffer}")

        byteBuffer1.put(123)

        println("byteBuffer.array() : ${byteBuffer.array()}")
        println("byteBuffer.slice().array() : ${byteBuffer1.array()}")
        @Assert("${byteBuffer1.array()}","${byteBuffer.array()}")

        println("byteBuffer : ${byteBuffer}")
        
        println("byteBuffer.slice() : ${byteBuffer1}")
    }
    @TestCase
    func nio_slice_341_5(): Unit {
        
        println("---------------------------nio_slice_341_5-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        println("byteBuffer.slice() : ${byteBuffer.slice(5,5)}")
        println("byteBuffer : ${byteBuffer}")
        @Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 mark=-1 pos=0 lim=0 cap=0]")

    }
    @TestCase
    func nio_slice_341_6(): Unit {
        var exc = ""
        println("---------------------------nio_slice_341_6-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        try{
            println("byteBuffer.slice() : ${byteBuffer.slice(6,0)}")
        } catch (e:Exception){
            exc = e.message
            // e.printStackTrace()
        }
        
        println("exc : ${exc}")
        // @Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

    }
    @TestCase
    func nio_slice_341_7(): Unit {
        var exc = ""
        println("---------------------------nio_slice_341_7-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        try{
            println("byteBuffer.slice() : ${byteBuffer.slice(0,6)}")
        } catch (e:Exception){
            exc = e.message
            // e.printStackTrace()
        }
        
        println("exc : ${exc}")
        // @Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

    }
    @TestCase
    func nio_slice_341_8(): Unit {
        var exc = ""
        println("---------------------------nio_slice_341_8-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        try{
            println("byteBuffer.slice() : ${byteBuffer.slice(-1,5)}")
        } catch (e:Exception){
            exc = e.message
            // e.printStackTrace()
        }
        
        println("exc : ${exc}")
        // @Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

    }
    @TestCase
    func nio_slice_341_9(): Unit {
        var exc = ""
        println("---------------------------nio_slice_341_9-----------------------------")
        var byteBuffer = ByteBuffer.wrap(Array<UInt8>(5,item:0),0,5)
        println("array() : ${byteBuffer.array()}")
        @Assert(byteBuffer.array(),Array<UInt8>(5,item:0))
    
        try{
            println("byteBuffer.slice() : ${byteBuffer.slice(0,-1)}")
        } catch (e:Exception){
            exc = e.message
            // e.printStackTrace()
        }
        
        println("exc : ${exc}")
        // @Assert("${byteBuffer.slice(5,5)}","ByteBuffer: [offset=5 pos=0 lim=0 cap=0]")

    }
}