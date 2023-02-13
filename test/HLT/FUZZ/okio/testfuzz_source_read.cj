//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj
//dependence:../utils/parseStringData.cj

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
     let buffer_1: Buffer = Buffer()
     let mybuffer = Buffer()
     mybuffer.writeUtf8(creatStr(byteCount + 1))
     var sourceIns_2:Source = mybuffer
     sourceIns_2.read(buffer_1,byteCount)
}

func creatStr(len:Int64):String{
    var charArr:Array<Char> = Array<Char>(len,item:'Q')
    return String(charArr)
}
 
func unboundTest():Unit{
    var case_name = CString("Fuzz_source_read")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}