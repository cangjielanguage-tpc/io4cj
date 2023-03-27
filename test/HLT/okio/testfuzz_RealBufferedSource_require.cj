//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(value: Int64){
    let arrb:Array<Byte> = "Fuzz_RealBufferedSource_require".toUtf8Array()
    let a_buffer2 = Buffer()
    a_buffer2.write(arrb)
    let source: Source = a_buffer2
    let bufferedSource: BufferedSource = Okio.buffer(source)
    if (value >= 0 && value < arrb.size) {
		bufferedSource.require(value)
	}else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSource_require")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}