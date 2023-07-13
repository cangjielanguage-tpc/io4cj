// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// public func writeSHA1(source: Buffer , byteCount: Int64)
func call_fuzz(value: Int64){
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let str1:String = "Fuzz_HashingSink_writeSHA1"
    let hashingSink: HashingSink = HashingSink.sha1(sink)
    source.writeUtf8(str1)
    if(value > 0 && value < str1.size){
        hashingSink.writeSHA1(source, value)
    }else{
        return
    }
    return
} 

func unboundTest():Unit{
    var case_name = CString("Fuzz_HashingSink_writeSHA1")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}