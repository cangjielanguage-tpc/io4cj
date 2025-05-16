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
    let buffer = Buffer()
    let sink: Sink = buffer
    let bufferedSink: BufferedSink = Okio.buffer(sink)
    if (value < Int64.Min || value > Int64.Max) {
		return
	}else{
        try{
            bufferedSink.writeInt32(value)
        }catch(e1:Exception){
            return
        }
    }
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_RealBufferedSink_writeInt32")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}