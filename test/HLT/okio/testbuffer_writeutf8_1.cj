// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj
//dependence:../utils/parseStringData.cj

from okio import okio.*
from std import unittest.*

/* 
    public static func buffer(sink: Sink): BufferedSink 
    func writeUtf8(string: String): BufferedSink
    
 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = -1
    var str_1:String =  """
                        """
    var str_2:String =  """
    Hello,
    Cangjie Lang\n"""
    let str_3 = ###"
    Hello,
    Cangjie
    Lang
    "###
    var arr_str:Array<String> = ["hello","仓颉","\"Hello Cangjie Lang\"",str_1,str_2,str_3]
    var data:String = ""
    var subData:String = ""
    var dataSize:Int64 = 0
    var funcData:(Int64,String) = (0,"")
    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Sink = Buffer()
        var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
        if(bufferIns is BufferedSink){
            returnFlag = 0
        }
        //将hello抓换为ascii表示： RealBufferedSink: [size=5] [104, 101, 108, 108, 111]
        data = bufferIns.writeUtf8(arr_str[0]).toString() 
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[0],52)
        @Assert(funcData[1],"111")

        /* ################################################# */
        data = bufferIns.writeUtf8(arr_str[1]).toString() 
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[0],83)
        @Assert(funcData[1],"137")

        /* ################################################# */
        data = bufferIns.writeUtf8(arr_str[4]).toString() 
        funcData = cla_1.parseData_utf8_1(data,4,length:3)
        @Assert(funcData[0],206)
        @Assert(funcData[1],"10")


        @Assert(returnFlag,0)
    }

}
