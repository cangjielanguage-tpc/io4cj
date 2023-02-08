// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(string: String) {
    ByteString.decodeBase64(string)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_ByteString.decodeBase64")
    unsafe {
        DT_FUZZ_String(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
