// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// func readUtf8LineStrict(limit: Int64): ?String
func call_fuzz(value: Int64){
    let a_buffer = Buffer()
    var str1:String = "Cangjie+华为\n中国+Fuzz_RealBufferedSource_readUtf8\rLineStrict"
    a_buffer.writeUtf8(str1)
    let source: Source = a_buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
    if (value >= 14 && value < str1.size) {
		bufferedSource.readUtf8LineStrict(value)
	}else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSource_readUtf8LineStrict")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}