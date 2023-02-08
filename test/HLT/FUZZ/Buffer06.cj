// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    if (int64 < 6) {
        return
    }
    let a_buffer = Buffer()
    a_buffer.writeUtf8("华为\n中国")
    a_buffer.readUtf8LineStrict(int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.readUtf8LineStrict")
    unsafe {
        DT_FUZZ_Int64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
