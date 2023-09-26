// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
//dependence:../utils/parseStringData.cj

from io4cj import okio.*
from std import unittest.*
from std import math.*

/* 
    public static func buffer(source: Source): BufferedSource 
    func read(sink: Buffer, byteCount: Int64): Int64

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var returnFlag:Int32 = -1
    var dataSize:Int64 = 0
    var data:String = ""
    var realData:String = ""
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        var sourceIns:Source = Buffer()
        // Okio.source(File("/home", Read, Open))
        var bufferIns:BufferedSource = Okio.buffer(sourceIns) // > BufferedSource
        let buffer_1: Buffer = Buffer()
        data = bufferIns.read(buffer_1,0).toString()   //sink为空Buffer
        funcData = cla_1.parseData_utf8_1(data,1,length:1)
        // println("buffer_1:>> ${buffer_1}") 
        @Assert(funcData[0],2)
        @Assert(data,"-1")

        //##############################################################
        // bufferIns.request(1)
         let mybuffer = Buffer()
        realData = mybuffer.writeUtf8("come on 得喂 【小高童鞋 && \"hello\"").toString()
        funcData = cla_1.parseData_utf8_1(realData,3,length:2)
        @Assert(funcData[0],205)
        @Assert(funcData[1],"34")
        var sourceIns_2:Source = mybuffer
         data = sourceIns_2.read(buffer_1,2).toString()   //sink为非空Buffer
        funcData = cla_1.parseData_utf8_1(data,1,length:1)
        @Assert(funcData[0],1)
        @Assert(data,"2")
        
        try{
            data = bufferIns.read(buffer_1,Int64.Min).toString()   //sink为非空Buffer，byteCount < 0
            funcData = cla_1.parseData_utf8_1(data,1,length:1)
        }catch(e1:Exception){
            // e1.printStackTrace()
            @Assert(cla_1.assertException(e1,"IllegalArgumentException"),true)
            returnFlag = 0
        }

        try{
            data = sourceIns_2.read(buffer_1,Int64.Min).toString()   //sink为非空Buffer，byteCount < 0
            funcData = cla_1.parseData_utf8_1(data,1,length:1)
        }catch(e1:Exception){
            // e1.printStackTrace()
            @Assert(cla_1.assertException(e1,"IllegalArgumentException"),true)
            returnFlag = 0
        }

        //##############################################################
        //sourceIns_2中还剩39字节，byteCount大于39，一次性全部写入到buffer_1，sourceIns_2.size = 0
        data = sourceIns_2.read(buffer_1,41).toString()  
        funcData = cla_1.parseData_utf8_1(data,2,length:1)
        @Assert(funcData[0],2)
        @Assert(data,"39")
        tuple_1 = cla_1.parseArrFromString(buffer_1.toString(),"[")
        @Assert(tuple_1[0][40],"34")
        @Assert(tuple_1[1],41)

        //##############################################################
        data = sourceIns_2.read(buffer_1,12).toString()   //sourceIns_2.size = 0
        funcData = cla_1.parseData_utf8_1(data,2,length:1)
        @Assert(funcData[0],2)
        @Assert(data,"-1")  
        tuple_1 = cla_1.parseArrFromString(buffer_1.toString(),"[")
        @Assert(tuple_1[0][40],"34")
        @Assert(tuple_1[1],41)           
        @Assert(returnFlag,0)
    }

}
