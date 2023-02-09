// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int641: InT64, int642: InT64) {
    var buffer = Buffer()
    buffer.write([6, 5, 4, 3, 2, 16, 7]).writeUtf8("华为").writeUtf8("中国")
    var buffer2 = Buffer()
    buffer.copyTo(buffer2, int641, int642)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_buffer.copyTo")
    unsafe {
        DT_FUZZ_Int64_2(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
