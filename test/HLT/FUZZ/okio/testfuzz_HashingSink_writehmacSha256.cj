//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// public func writehmacSha256(source: Buffer , byteCount: Int64)
func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let str1:String = creatStr(value +1)
    let hashingSink: HashingSink = HashingSink.hmacSha256(sink,str1)
    source.writeUtf8(str1)
    hashingSink.writehmacSha256(source, value)
} 

func creatStr(len:Int64):String{
    var charArr:Array<Char> = Array<Char>(len,item:'Q')
    return String(charArr)
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_HashingSink_writehmacSha256")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}