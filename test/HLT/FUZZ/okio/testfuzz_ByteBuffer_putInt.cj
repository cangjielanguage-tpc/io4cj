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

// public func putInt(value: Int32): ByteBuffer
func call_fuzz(value: Int32){
    if (value < Int32.Min || value > Int32.Max) {
		return
	}
    var byteBuffer = ByteBuffer.wrap(creatArr(value + 1),0,value + 1)
    var putInt = byteBuffer.putInt(value)
} 

func creatArr(len:Int32):Array<Byte>{
    var byteArr:Array<Byte> = Array<Byte>(Int64(len),item:1)
    for(i in 0..Int64(len)){
        if(UInt8(i) < UInt8.Max){
            byteArr[i] = UInt8(i)
        }else{
            break
        }
    }
    return byteArr
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_ByteBuffer_putInt")
    unsafe{
        DT_FUZZ_Int32(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}