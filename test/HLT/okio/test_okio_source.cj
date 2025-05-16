// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
//dependence:../utils/parseStringData.cj
//data_file:basefile.txt

import io4cj.*
import std.posix.*
import std.unittest.*
import std.fs.*

/* 
    public static func buffer(source: Source): BufferedSource
    public static func source(file: File): Source
    func read(sink: Buffer, byteCount: Int64): Int64

 */

@Test
public class OkioTest {
    let cla_1:ParseDataStr = ParseDataStr()
    var path_base: String = getcwd()
    var returnFlag:Int32 = 0
    var data:String = ""
    var realData:String = ""
    var funcData:(Int64,String) = (0,"")

    @TestCase
    func testBuffer(): Unit {
        // class Buffer <: BufferedSource & BufferedSink &&  BufferedSource <: Source
        let file:File = File("${path_base}/basefile.txt", OpenMode.ReadWrite)
        var sourceIns:Source = Okio.source(file)
        let buffer_1: Buffer = Buffer()
        var bufferedsourceIns:BufferedSource = Okio.buffer(sourceIns) // > BufferedSource
        data = bufferedsourceIns.read(buffer_1,0).toString()   //sink为空Buffer
        funcData = cla_1.parseData_utf8_1(data,1,length:1)
        // println("buffer_1:>> ${buffer_1}") 
        @Assert(funcData[0],1)
        @Assert(data,"0")

        //##############################################################
        let mybuffer = Buffer()
        realData = mybuffer.writeUtf8("come on 得喂 【小高童鞋 && \"hello\"").toString()
        funcData = cla_1.parseData_utf8_1(realData,3,length:2)
        @Assert(funcData[0],205)
        @Assert(funcData[1],"34")
        var sourceIns_2:Source = mybuffer
        data = sourceIns_2.read(buffer_1,2).toString()   
        funcData = cla_1.parseData_utf8_1(data,1,length:1)
        @Assert(funcData[0],1)
        @Assert(data,"2")

        @Assert(returnFlag,0)
    }

}
