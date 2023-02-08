// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    let bufferedSink = okio.Buffer()
    bufferedSink.writeInt8(int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bufferedSink.writeInt8")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
