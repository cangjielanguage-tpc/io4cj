// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.* 
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList


func call_fuzz(value: Int64){
    let arrb:Array<Byte> = "Fuzz_RealBufferedSource_require".toUtf8Array()
    let a_buffer2 = Buffer()
    a_buffer2.write(arrb)
    let source: Source = a_buffer2
    let bufferedSource: BufferedSource = Okio.buffer(source)
    if (value >= 0 && value < arrb.size) {
		bufferedSource.require(value)
	}else{
        return
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSource_require")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}