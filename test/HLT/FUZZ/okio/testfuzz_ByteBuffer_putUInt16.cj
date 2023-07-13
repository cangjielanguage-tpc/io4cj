// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from okio import okio.*
from okio import nio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// public func putUInt16(value: UInt16): ByteBuffer
func call_fuzz(value: UInt16){
    var str1:String = "Fuzz_ByteBuffer_putUInt16"
    var byteBuffer = ByteBuffer.wrap(str1.toUtf8Array())
    if(value >= 0 && value < UInt16(str1.size)){
        byteBuffer.putUInt16(value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_putUInt16")
    unsafe{
        DT_FUZZ_UInt16(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}