// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
//dependence:../utils/parseStringData.cj

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import io4cj.*
import std.unittest.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func write(source: Source, byteCount: Int64): BufferedSink
    func write(source: Buffer, byteCount: Int64): Unit

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = 0

    var data:String = ""
    var data_2:String = ""
    var funcData:(Int64,String) = (0,"")
    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Sink = Buffer()
        let buffer_1: Buffer = Buffer()
        var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
        @Assert(bufferIns is BufferedSink , true)
        //func write(source: Source, byteCount: Int64): BufferedSink
        let source_1: Source =  Buffer()
        data = bufferIns.write(source_1,0).toString() //缓冲区为空
        @Assert(cla_1.assertNa(data), true)

        // func write(source: Buffer, byteCount: Int64): Unit
        bufferIns.write(buffer_1,0) //缓冲区为空
        data_2 = bufferIns.toString() 
        @Assert(cla_1.assertNa(data), true)
        
        var realData = buffer_1.writeUtf8("abcd").toString() 
        funcData = cla_1.parseData_utf8_1(realData,4)
        @Assert(funcData[0],26)
        @Assert(funcData[1],"100")

        // func write(source: Buffer, byteCount: Int64): Unit
        bufferIns.write(buffer_1,3) 
        data_2 = bufferIns.toString() 
        funcData = cla_1.parseData_utf8_1(data_2,4)
        @Assert(funcData[1],"99")

        let source_2: Source =  buffer_1
        try{
            data = bufferIns.write(source_2,1).toString() // 预期[97, 98, 99, 100]
        }catch(e1:Exception){
             e1.printStackTrace()
            returnFlag = 1
        }
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[1],"100")

        try{
            data = bufferIns.write(source_2,-1).toString() // 预期[97, 98, 99, 100]
        }catch(e1:Exception){
            // e1.printStackTrace()
            returnFlag = 2
        }
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[1],"100")

        @Assert(returnFlag,0)
    }

}

