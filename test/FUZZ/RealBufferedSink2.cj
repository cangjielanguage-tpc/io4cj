// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
from std import io.*
from std import time.*
from io4cj import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(string: String) {
    let bufferedSink = okio.Buffer()
    bufferedSink.writeUtf8(string)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bufferedSink.writeUtf8")
    unsafe {
        DT_FUZZ_String(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
