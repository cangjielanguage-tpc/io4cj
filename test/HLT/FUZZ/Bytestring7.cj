// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    if (int64 > 0 || int64 < 10) {
        return
    }
    let str = "hello world"
    let arr: Array<Byte> = str.toUtf8Array()
    let bs = ByteString(arr)
    println("bs = ${bs.getByte(int64)}")
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bs.getByte")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
