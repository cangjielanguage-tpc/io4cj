// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
//dependence:../utils/parseStringData.cj
//data_file:basefile.txt

from io4cj import okio.*
from std import os.posix.*
from std import unittest.*
from std import fs.*

/* 
    public static func buffer(sink: Sink): BufferedSink
    public static func sink(file: File): Sink 
    func writeUtf8(string: String): BufferedSink

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var path_base: String = getcwd()
    var returnFlag:Int32 = -1
    var data:String = ""
    var funcData:(Int64,String) = (0,"")
    var tuple_1:(Array<String>,Int64) = (Array<String>(),0)

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        let file:File = File("${path_base}/basefile.txt", OpenOption.Open(true,true))
        // let file:File = File("${path_base}/basefile.txt",OpenOption.Create(true))
        var sinkIns:Sink = Okio.sink(file)
        var bufferedSinkIns = Okio.buffer(sinkIns) // > BufferedSink

        //##############################################################
        data = bufferedSinkIns.writeUtf8("hello").toString() 
        bufferedSinkIns.close() //将bufferedSinkIns中的字符序列"hello"写入到当前File中
        funcData = cla_1.parseData_utf8_1(data,4)
        // println("data2:>> ${data}")
        @Assert(funcData[0],52)
        @Assert(funcData[1],"111")
        tuple_1 = cla_1.parseArrFromString(data,"[")
        @Assert(tuple_1[0][2],"108")
        @Assert(tuple_1[1],5)    

        try{
            let file_2:File = File("${path_base}/sourcefile/base呀吼file.txt", Open(true,true))
            var _:Sink = Okio.sink(file_2)
            var bufferedSinkIns_2 = Okio.buffer(sinkIns) // > BufferedSink
            data = bufferedSinkIns_2.writeUtf8("hello").toString() 
        }catch(e1:Exception){
            // e1.printStackTrace()
            @Assert(cla_1.assertException(e1,"FSException:"),true)
            returnFlag = 0
        }

        @Assert(returnFlag,0)
    }

}
