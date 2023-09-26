// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from io4cj import okio.*
from io4cj import nio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
from std import runtime.*

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