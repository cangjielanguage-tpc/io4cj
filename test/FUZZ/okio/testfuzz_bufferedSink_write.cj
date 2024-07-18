// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList


func call_fuzz(byteCount:Int64){
    var sourceIns:Sink = Buffer()
    let buffer_1: Buffer = Buffer()
    var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
    var str1:String = "Fuzz_BufferedSink_write"
    buffer_1.writeUtf8(str1)
    if(byteCount >= 0 && byteCount < str1.size){
        bufferIns.write(buffer_1,byteCount) 
    }else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_write")  
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}