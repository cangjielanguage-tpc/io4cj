// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import io4cj.*
import io4cj.*
import std.unittest.*
import std.io.*
import std.math.* 
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
import std.runtime.*

// public static func allocate(capacity: Int64): ByteBuffer
func call_fuzz(value: Int64){
    if (value < 0 || Float64(value) >= Float64(MemoryInfo.maxHeapSize)*0.8) {
		return
	}
   var byteBuffer = ByteBuffer.allocate(value)
   return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_allocate")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}