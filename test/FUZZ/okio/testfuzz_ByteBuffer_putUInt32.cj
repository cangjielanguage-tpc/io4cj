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

// public func putUInt32(value: UInt32): ByteBuffer
func call_fuzz(value: UInt32){
    var str1:String = "Fuzz_ByteBuffer_putUInt32"
    var byteBuffer = ByteBuffer.wrap(str1.toUtf8Array())
    if(value >= 0 && value < UInt32(str1.size)){
        byteBuffer.putUInt32(value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_putUInt32")
    unsafe{
        DT_FUZZ_UInt32(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}