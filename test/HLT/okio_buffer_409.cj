// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*
import std.fs.*

@Test
public class okio_byteString_409 {

    @TestCase//获取此BufferedSink的缓冲对象
    func okio_buffer_473(): Unit {
    var str = Buffer()
    var str1 = str.getBuffer()
    var str2 = str.write(Array<Byte>())
    var str3 = str.write(Array<Byte>(5, repeat: 1),1,2)
    var str5 = str.writeUtf8CodePoint(2047)
    var str6 = str.writeUtf8CodePoint(65535)
    var str7 = str.writeUtf8CodePoint(55298)
    var str8 = str.writeUtf8CodePoint(57345)
    var str9 = str.writeUtf8CodePoint(1114111)
    var str122 = str.readUtf8CodePoint()
    var str20 = str.readByteString(10)
    try{
    var str18 = str.readDecimalInt64()
    var str19 = str.readHexadecimalUInt64()
    } catch(e: Exception) {
        println("case pass")
    }
    println(str122)

    println(str20.size)

    @Assert(str122 , 1)
    @Assert(str20.size , 10)

    }

}
