// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int641: InT64, int642: InT64) {
    if (int641 < 0 || int64 > 11 && int642 < 0 || int642 > 11 && int641 > int642) {
        return
    }
    let str = "hello world"
    let arr: Array<Byte> = str.toUtf8Array()
    println(arr)
    let bs = ByteString(arr)
    println("bs = ${bs.substring(int641,int642)}")
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bs.substring")
    unsafe {
        DT_FUZZ_Int64_2(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
