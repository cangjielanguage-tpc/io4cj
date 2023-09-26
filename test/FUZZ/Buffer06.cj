// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
from std import io.*
from std import time.*
from io4cj import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {
    if (int64 < 6) {
        return
    }
    let a_buffer = Buffer()
    a_buffer.writeUtf8("华为\n中国")
    a_buffer.readUtf8LineStrict(int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.readUtf8LineStrict")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
