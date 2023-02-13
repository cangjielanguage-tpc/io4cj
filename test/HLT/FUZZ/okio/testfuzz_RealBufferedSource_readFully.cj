//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

// func readFully(sink: Buffer, byteCount: Int64): Unit
func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    let arrb:Array<Byte> = creatArr(value)
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    let a_buffer2 = Buffer()
    let source: Source = a_buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
    bufferedSource.readFully(a_buffer2,value)
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
    var case_name = CString("Fuzz_RealBufferedSource_readFully")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}