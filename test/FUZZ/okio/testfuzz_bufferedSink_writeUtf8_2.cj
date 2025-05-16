// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import io4cj.*
import std.unittest.*
import std.io.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList

func call_fuzz(str: String, beginIndex: Int64, endIndex: Int64){
    var buffer_1: Buffer = Buffer()
    if(beginIndex >= 0 && endIndex >= beginIndex &&  endIndex < str.size){
        buffer_1.writeUtf8(str,beginIndex,endIndex)
    }else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_writeUtf8_2")
    unsafe{
        DT_FUZZ_String_Int64_2(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}