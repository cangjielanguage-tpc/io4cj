// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from io4cj import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(value:Int64){
    let str1:String = "Fuzz_source_read_&&_&%$#$&*{}kongvygcvfygv"
    let buffer_1: Buffer = Buffer()
    let mybuffer = Buffer()
    mybuffer.writeUtf8(str1)
    var sourceIns_2:Source = mybuffer
    if (value >= 0 && value < str1.size) {
		sourceIns_2.read(buffer_1,value)
	}else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_source_read")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}