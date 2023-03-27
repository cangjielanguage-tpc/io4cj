//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from okio import nio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

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