// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: Int64) {
    var byteString = ByteString("hello world".toUtf8Array())
    var byteArray: Array<Byte> = "l".toUtf8Array()
    byteString.lastIndexOf(byteArray, int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_byteString.lastIndexOf")
    unsafe {
        DT_FUZZ_Int64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
