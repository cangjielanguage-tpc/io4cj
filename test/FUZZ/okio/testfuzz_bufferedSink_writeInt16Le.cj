// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import io4cj.*
import std.unittest.*
import std.io.*
import std.math.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList


func call_fuzz(value: Int64){
    if (value < Int64.Min || value > Int64.Max) {
		return
	}
    var sourceIns:Sink = Buffer()
    var bufferIns = Okio.buffer(sourceIns) // > BufferedSink
    bufferIns.writeInt16Le(value)
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BufferedSink_writeInt16Le")
    unsafe{
        DT_FUZZ_Int64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}