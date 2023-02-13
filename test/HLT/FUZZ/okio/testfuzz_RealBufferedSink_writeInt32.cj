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
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    let buffer = okio.Buffer()
    let sink: Sink = buffer
    let bufferedSink: BufferedSink = Okio.buffer(sink)
    bufferedSink.writeInt32(value)
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSink_writeInt32")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}