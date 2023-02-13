//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(byteCount:Int64){
	if (byteCount < 0 || byteCount > 0xFFFFFFFF) {
		return
	}
    var sourceIns:Sink = Buffer()
    let buffer_1: Buffer = Buffer()
    var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
    buffer_1.writeUtf8(creatStr(byteCount))
    bufferIns.write(buffer_1,byteCount) 

}

func creatStr(len:Int64):String{
    var charArr:Array<Char> = Array<Char>(len,item:'Q')
    return String(charArr)
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_write")  
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}