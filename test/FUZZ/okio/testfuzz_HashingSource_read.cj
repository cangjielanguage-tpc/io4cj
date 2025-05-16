// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.* 
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList

// public func writehmacSha256(source: Buffer , byteCount: Int64)
func call_fuzz(value: Int64){
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let str1:String = "Fuzz_HashingSource_read"
    let hashingSource: HashingSource = HashingSource.hmacSha256(source,str1)
    source.writeUtf8(str1)
    if(value >= 0 && value < str1.size){
        hashingSource.read(sink, value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_HashingSource_read")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}