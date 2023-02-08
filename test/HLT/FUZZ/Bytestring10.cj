// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    var byteString = ByteString("hello world".toUtf8Array())
    var byteString2 = ByteString("l".toUtf8Array())
    var idx = byteString.lastIndexOf(byteString2, int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_byteString.lastIndexOf")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
