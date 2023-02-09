// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    if (int64 > 11 || int64 < 1) {
        return
    }
    var arr: Array<Byte> = "hello world".toUtf8Array()
    var bas = ByteArrayStream()
    bas.write(arr)
    ByteString.read(bas, int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_ByteString.read")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
