// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {
    if (int64 > 1100000) {
        return
    }
    let bufferedSink = okio.Buffer()
    bufferedSink.writeUtf8CodePoint(int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bufferedSink.writeUtf8CodePoint")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
