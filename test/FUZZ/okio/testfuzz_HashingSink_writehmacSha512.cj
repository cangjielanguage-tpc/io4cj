// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.* 
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList

// public func writehmacSha512(source: Buffer , byteCount: Int64)
func call_fuzz(value: Int64){
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let str1:String = "Fuzz_HashingSink_writehmacSha512"
    let hashingSink: HashingSink = HashingSink.hmacSha512(sink,str1)
    source.writeUtf8(str1)
    if(value > 0 && value < str1.size){
        hashingSink.writehmacSha512(source, value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_HashingSink_writehmacSha512")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}