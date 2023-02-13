//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// func indexOf(bytes: ByteString, fromIndex: Int64): Int64
func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    let arrb:Array<Byte> = creatArr(value + 1)
    let a_buffer2 = Buffer()
    a_buffer2.write(arrb)
    let source: Source = a_buffer2
    let bufferedSource: BufferedSource = Okio.buffer(source)
    bufferedSource.indexOf(ByteString(arrb),value)
} 

func creatArr(len:Int64):Array<Byte>{
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
    var case_name = CString("Fuzz_RealBufferedSource_indexOf")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}