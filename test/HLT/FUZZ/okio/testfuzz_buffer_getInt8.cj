//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(pos: Int64){
    if (pos < Int64.Min || pos > Int64.Max) {
		return
	}
    var buffer = Buffer()
    buffer.writeUtf8(creatStr(pos + 1))
    buffer.getInt8(pos)
}

func creatStr(len:Int64):String{
    var charArr:Array<Char> = Array<Char>(len,item:'Q')
    return String(charArr)
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_Buffer_getInt8")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}