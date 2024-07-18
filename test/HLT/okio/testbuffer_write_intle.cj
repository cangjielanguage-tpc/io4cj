// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
//dependence:../utils/parseStringData.cj

import io4cj.*
import std.unittest.*
import std.math.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func writeInt16Le(value: Int64): BufferedSink
    func writeInt32Le(value: Int64): BufferedSink
    func writeInt64Le(value: Int64): BufferedSink

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

        data = bufferIns.writeInt16Le(123).toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        @Assert(funcData[0],35)
        @Assert(funcData[1],"0")

        data = bufferIns.writeInt32Le(-12).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],55)
        @Assert(funcData[1],"255")

         data = bufferIns.writeInt64Le(Int64.Min).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],82)
        @Assert(funcData[1],"128")

        data = bufferIns.writeInt16Le(Int64.Max).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],92)
        @Assert(funcData[1],"255")

        data = bufferIns.writeInt32Le(0).toString() 
        funcData = cla_1.parseData_utf8_1(data,3,length:2)
        tuple_1 = cla_1.parseArrFromString(data,"[")
        @Assert(funcData[0],104)
        @Assert(tuple_1[1],20)
        @Assert(funcData[1],"0")  

        @Assert(returnFlag,0)
    }

}
