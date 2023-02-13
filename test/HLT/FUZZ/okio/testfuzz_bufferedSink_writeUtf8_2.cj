//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(str: String, beginIndex: Int64, endIndex: Int64){
    if (beginIndex < 0 && endIndex < 0 || endIndex < beginIndex || beginIndex > 0xFFFFFFFF) {
		return
	}
    var buffer_1: Buffer = Buffer()
    buffer_1.writeUtf8(str,beginIndex,endIndex)

}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_writeUtf8_2")
    unsafe{
        DT_FUZZ_String_Int64_2(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}