// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
//dependence:../utils/parseStringData.cj

from io4cj import okio.*
from std import unittest.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func emit(): BufferedSink

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = 0
    var dataSize:Int64 = 0
    var data:String = ""
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Sink = Buffer()
        var bufferIns:BufferedSink = Okio.buffer(sourceIns) // > BufferedSink
        var bufferIns_2:BufferedSink = Okio.buffer(bufferIns) // > BufferedSink

        data = bufferIns.emit().toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        // println("data2:>> ${data}")
        @Assert(funcData[0],29)
        @Assert(cla_1.assertNa(data),true)

        data = bufferIns_2.emit().toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        // println("data2:>> ${data}")
        @Assert(funcData[0],29)
        @Assert(cla_1.assertNa(data),true)
        data = bufferIns_2.writeUtf8("come on 得喂 【小高童鞋 && \"hello\"").toString() 
        funcData = cla_1.parseData_utf8_1(data,4)
        tuple_1 = cla_1.parseArrFromString(data,"[")
        // println("data2:>> ${data}")
        @Assert(funcData[0],223)
        @Assert(funcData[1],"34")
        @Assert(tuple_1[1],41)

        @Assert(returnFlag,0)
    }

}
