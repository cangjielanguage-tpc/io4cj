// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    if (int64 > 11 || int64 < 0) {
        return
    }
    var bs = ByteString.of("hello world".toUtf8Array(), 0, int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_ByteString.of")
    unsafe {
        DT_FUZZ_Int64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
