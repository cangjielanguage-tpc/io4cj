// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.* 
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
import std.runtime.*


func call_fuzz(offset: Int64,byteCount: Int64){
    let arrb:Array<Byte> = "Fuzz_RealBufferedSource_read".toUtf8Array()
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    let arrb2 :Array<Byte> = Array<Byte>(arrb.size, repeat: 0)
    let source: Source = a_buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
    if (offset < 0 || byteCount < 0  || byteCount > MemoryInfo.maxHeapSize || offset >  MemoryInfo.maxHeapSize ) {
        return
	}else{
        try{
            bufferedSource.read(arrb2,offset,byteCount)
        }catch(e1:Exception){
            return
        }
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSource_read")
    unsafe{
        DT_FUZZ_Int64_2(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}