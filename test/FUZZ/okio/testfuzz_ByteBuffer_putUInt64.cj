// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import io4cj.*
import io4cj.*
import std.unittest.*
import std.io.*
import std.math.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList

// public func putUInt64(value: UInt64): ByteBuffer
func call_fuzz(value: UInt64){
    var str1:String = "Fuzz_ByteBuffer_putUInt64"
    var byteBuffer = ByteBuffer.wrap(str1.toUtf8Array())
    if(value >= 0 && value < UInt64(str1.size)){
        byteBuffer.putUInt64(value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_putUInt64")
    unsafe{
        DT_FUZZ_UInt64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}