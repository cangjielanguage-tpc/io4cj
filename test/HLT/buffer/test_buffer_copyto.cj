// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj
//dependence:../utils/parseStringData.cj

from okio import okio.*
from std import os.posix.*
from std import unittest.*

/* 
    public static func buffer(source: Source): BufferedSource 
    public func copyTo(out: Buffer, offset: Int64, byteCount: Int64): Buffer

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = -1
    var data:String = ""
    var realData:String = ""
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        var buffer = Buffer()
        var baseBuffer2 = Buffer()
        buffer.write([6, 5, 4, 3, 2, 16, 7])
            .writeUtf8("华为")
            .writeUtf8("中国")
        var buffer2 = Buffer()
        let s = buffer.size

        //源buffer非空，目标buffer为空
        data = buffer.copyTo(buffer2, 0, buffer.size).toString()
        funcData = cla_1.parseData_utf8_1(buffer2.toString(),4)
        @Assert(funcData[0],92)
        tuple_1 = cla_1.parseArrFromString(buffer2.toString(),"[")
        @Assert(tuple_1[0][16],"229")
        @Assert(tuple_1[1],19)
        println("data2:>> ${buffer2}")

        //源buffer非空，目标buffer非空
        baseBuffer2.writeUtf8("目标")
        try{
            data = baseBuffer2.copyTo(buffer2, 0, buffer.size).toString()
        }catch(e1:Exception){
            @Assert(cla_1.assertException(e1,"ArrayIndexOutOfBoundsException"),true)
            returnFlag = 0
        }

        try{
            data = baseBuffer2.copyTo(buffer2, -2, baseBuffer2.size).toString()
        }catch(e2:Exception){
            // e2.printStackTrace()
            @Assert(cla_1.assertException(e2,"ArrayIndexOutOfBoundsException"),true)
            returnFlag = 0
        }

        data = baseBuffer2.copyTo(buffer2, 0, baseBuffer2.size).toString() //size=25
        funcData = cla_1.parseData_utf8_1(data,4)

        @Assert(funcData[0],39)
        tuple_1 = cla_1.parseArrFromString(buffer2.toString(),"[")
        @Assert(tuple_1[0][16],"229")
        if(tuple_1[1] == 25){
            returnFlag = 0
        }else{
            returnFlag = 1
        }

        //源buffer为空，目标buffer为空
        baseBuffer2.clear()
        buffer2.clear()
        data = baseBuffer2.copyTo(buffer2, 0, baseBuffer2.size).toString()
        funcData = cla_1.parseData_utf8_1(buffer2.toString(),4)
        @Assert(cla_1.assertNa(buffer2.toString()),true)

        @Assert(returnFlag,0)
    }

}
