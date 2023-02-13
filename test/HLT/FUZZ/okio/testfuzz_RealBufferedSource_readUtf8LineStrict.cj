//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// func readUtf8LineStrict(limit: Int64): ?String
func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
        if(value < 1){
		    return
        }
	}
    let a_buffer = Buffer()
    a_buffer.writeUtf8("Cangjie+华为\n中国")
    let source: Source = a_buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
    bufferedSource.readUtf8LineStrict(value)
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSource_readUtf8LineStrict")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}