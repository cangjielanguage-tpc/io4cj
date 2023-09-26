// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
//dependence:../utils/parseStringData.cj

from io4cj import okio.*
from std import unittest.*
from std import math.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func writeInt8(value: Int64): BufferedSink
    func writeInt16(value: Int64): BufferedSink
    func writeInt32(value: Int64): BufferedSink
    func writeInt64(value: Int64): BufferedSink

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = -1
    var dataSize:Int64 = 0
    var data:String = ""
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Sink = Buffer()
        var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
        if(bufferIns is BufferedSink){
            returnFlag = 0
        }

        data = bufferIns.writeInt8(12).toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        @Assert(funcData[0],31)
        @Assert(funcData[1],"12")

        data = bufferIns.writeInt16(Int64.Max).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],41)
        @Assert(funcData[1],"255")

        data = bufferIns.writeInt32(Int64.Min).toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        tuple_1 = cla_1.parseArrFromString(data,"[")
        @Assert(funcData[0],53)
        @Assert(funcData[1],"0")
        @Assert(tuple_1[1],7)

        data = bufferIns.writeInt64(-32).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],94)
        @Assert(funcData[1],"224")

        data = bufferIns.writeInt8(0).toString() 
        funcData = cla_1.parseData_utf8_1(data,2,length:1)
        tuple_1 = cla_1.parseArrFromString(data,"[")
        @Assert(funcData[0],97)
        @Assert(funcData[1],"0")
        @Assert(tuple_1[1],16)

        @Assert(returnFlag,0)
    }

}
