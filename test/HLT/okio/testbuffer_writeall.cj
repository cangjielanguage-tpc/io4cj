// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
//dependence:../utils/parseStringData.cj

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from io4cj import nio.ByteBuffer
from std import unittest.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func writeAll(source: Source): Int64
 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = 0
    var data:String = ""
    var realData:String = ""
    var funcData:(Int64,String) = (0,"")
    var source_2: Source = Buffer()

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Sink = Buffer()
        let buffer_1: Buffer = Buffer()
        var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
        @Assert(bufferIns is BufferedSink , true)
        //func write(source: Source, byteCount: Int64): BufferedSink
        let source_1: Source =  Buffer()
        data = bufferIns.writeAll(source_1).toString() //缓冲区为空
        @Assert(data,"0")

        realData = buffer_1.writeUtf8("abcd").toString() 
        funcData = cla_1.parseData_utf8_1(realData,4)
        @Assert(funcData[0],26)
        @Assert(funcData[1],"100")

        source_2 =  buffer_1
        try{
            data = bufferIns.writeAll(source_2).toString() // 预期[97, 98]
            println("data3:>> ${data}")
        }catch(e1:Exception){
            returnFlag = 1
        }
        @Assert(data,"4")
        
        realData = buffer_1.writeUtf8("磨人的小妖精。啊】【哈").toString() 
        funcData = cla_1.parseData_utf8_1(realData,4)
        @Assert(funcData[0],175)
        @Assert(funcData[1],"136")
        source_2 =  buffer_1
        data = bufferIns.writeAll(source_2).toString() 
        @Assert(data,"33")

        @Assert(returnFlag,0)
    }

}

