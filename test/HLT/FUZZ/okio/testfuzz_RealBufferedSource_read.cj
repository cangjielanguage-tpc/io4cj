//3rd_party_lib:okio/build/okio
//3rd_party_lib:okio/ci_lib/cryptocj

from okio import okio.*
from std import unittest.*
from std import io.*
from std import math.* 
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(len: Int64,offset: Int64,byteCount: Int64){
    if (len < Int64.Min || offset < Int64.Min || byteCount < 0  || byteCount > Int64.Max || offset > Int64.Max || len > Int64.Max) {
		 if (offset >= len || byteCount >= len || offset+byteCount >= len){
            return
        }
	}
    let arrb:Array<Byte> = creatArr(len)
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    let arrb2 :Array<Byte> = Array<Byte>(len,item:0)
    let source: Source = a_buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
    bufferedSource.read(arrb2,offset,byteCount)
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
    var case_name = CString("Fuzz_RealBufferedSource_request")
    unsafe{
        DT_FUZZ_Int64_3(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}