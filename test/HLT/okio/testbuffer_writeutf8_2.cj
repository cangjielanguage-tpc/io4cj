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
    func writeUtf8(string: String, beginIndex: Int64, endIndex: Int64): BufferedSink

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
        if(!(bufferIns is BufferedSink)){
            returnFlag = returnFlag
        }
        //将hello抓换为ascii表示： RealBufferedSink: [size=5] [104, 101, 108, 108, 111]
        data = bufferIns.writeUtf8(arr_str[0],0,arr_str[0].size).toString() 
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[0],52)
        @Assert(funcData[1],"111")

        /* ################################################# */
        data = bufferIns.writeUtf8(arr_str[1],0,1).toString() 
        // println("data1:>> ${data}")
        funcData = cla_1.parseData_utf8_1(data,4)
        @Assert(funcData[0],67)
        @Assert(funcData[1],"147")

        /* ################################################# */
        try{
            data = bufferIns.writeUtf8(arr_str[4],-1,1).toString() 
        }catch(e1:Exception){
            returnFlag = 0
        }

        try{
            data = bufferIns.writeUtf8(arr_str[4],1,-2).toString() 
        }catch(e2:Exception){
            returnFlag = returnFlag
        }

        try{
            data = bufferIns.writeUtf8(arr_str[4],1,arr_str[4].size+2).toString() 
        }catch(e3:Exception){
            returnFlag = returnFlag
        }


        @Assert(returnFlag,0)
    }

}

