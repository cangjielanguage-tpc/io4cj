//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(offset: Int64,byteCount: Int64){
    var buffer = Buffer()
    var str1:String = "Fuzz_Buffer_copyTo"
    buffer.writeUtf8(str1)
    var buffer2 = Buffer()        
    if(offset >= 0 && byteCount >= 0 && byteCount < Int64.Max - offset && offset+byteCount < str1.size){
        buffer.copyTo(buffer2, offset, byteCount)
    }else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_Buffer_copyTo")
    unsafe{
        DT_FUZZ_Int64_2(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}