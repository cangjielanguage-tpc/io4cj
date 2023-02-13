//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from okio import nio.*
from std import unittest.*
from std import io.*
from std import math.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// public func putUInt64(value: UInt64): ByteBuffer
func call_fuzz(value: UInt64){
    if (value < UInt64.Min || value > UInt64.Max) {
		return
	}
    var byteBuffer = ByteBuffer.wrap(creatArr(value + 1),0,value + 1)
    byteBuffer.putUInt64(value)
} 

func creatArr(len:UInt64):Array<Byte>{
    var byteArr:Array<Byte> = Array<Byte>(len,item:1)
    for(i in 0..len){
        if(UInt8(i) < UInt8.Max){
            byteArr[i] = UInt8(i)
        }else{
            break
        }
    }
    return byteArr
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_putUInt64")
    unsafe{
        DT_FUZZ_UInt64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}