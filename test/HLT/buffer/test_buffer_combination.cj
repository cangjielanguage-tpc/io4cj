// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
//dependence:../utils/parseStringData.cj

import io4cj.*
import std.unittest.*
import std.io.*

/* 
    public static func buffer(sink: Sink): BufferedSink
    public static func sink(file: File): Sink 
    func writeUtf8(string: String): BufferedSink
    public func completeSegmentByteCount(): Int64 
    public func clear(): Unit 
    public func getInt8(pos: Int64): Int8

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = -1
    var data:String = ""
    var subData:Int8 = 0
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        let sinkIns:Sink = Buffer()
        var _:BufferedSink = Okio.buffer(sinkIns) // > BufferedSink
        let buffer_1:Buffer = Buffer()

        data = buffer_1.completeSegmentByteCount().toString()
        try{
            buffer_1.clear() //当前空buffer实例clear时会异常
        }catch(e1:Exception){
            // e1.printStackTrace()
            returnFlag = returnFlag
        }
        data = buffer_1.writeUtf8("\"Hello Cangjie Lang\"").toString()
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[0],101)
        tuple_1 = cla_1.parseArrFromString(data,"[")
        @Assert(tuple_1[0][18],"103")
        @Assert(tuple_1[1],20)

        subData = buffer_1.getInt8(1)  //72
        // println("subData:>> ${subData}")
        @Assert(subData,72)
        data = buffer_1.completeSegmentByteCount().toString()
        @Assert(data,"0")

        buffer_1.clear() //清空非空实例buffer_1
        funcData = cla_1.parseData_utf8_1(buffer_1.toString(),1,length:1)
        @Assert(funcData[0],11)
        try{
            subData = buffer_1.getInt8(1) //当前buffer_1为空，getInt8索引越界
        }catch(e2:Exception){
            // e2.printStackTrace()
            @Assert(cla_1.assertException(e2,"IndexOutOfBoundsException"),true)
            returnFlag = 0

        }


        @Assert(returnFlag,0)
    }

}
