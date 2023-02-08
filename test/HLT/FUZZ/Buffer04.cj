// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    let arrb: Array<Byte> = [6, 5, 4, 3, 2, 16, 7]
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    a_buffer.request(int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.request")
    unsafe {
        DT_FUZZ_Int64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
