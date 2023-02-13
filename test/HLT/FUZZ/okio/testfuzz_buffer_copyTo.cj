//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(offset: Int64,byteCount: Int64){
    if (offset < Int64.Min || byteCount < 0  || byteCount > Int64.Max || offset > Int64.Max) {
		return
	}
    var buffer = Buffer()
    buffer.writeUtf8(creatStr(byteCount))
    var buffer2 = Buffer()        
    buffer.copyTo(buffer2, offset, byteCount)
}

func creatStr(len:Int64):String{
    var charArr:Array<Char> = Array<Char>(len,item:'Q')
    return String(charArr)
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_Buffer_copyTo")
    unsafe{
        DT_FUZZ_Int64_2(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}