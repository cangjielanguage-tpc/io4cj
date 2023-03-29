//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

func call_fuzz(pos: Int64){
    var buffer = Buffer()
    var str1:String = "Fuzz_Buffer_getInt8"
    buffer.writeUtf8(str1)
    if(pos >= 0 && pos < str1.size){
        buffer.getInt8(pos)
    }else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_Buffer_getInt8")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}