// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from io4cj import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    var sourceIns:Sink = Buffer()
    var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
    bufferIns.writeInt8(value)
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_writeInt8")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}