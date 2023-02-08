// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int8: Int8) {
    if (int64 < 0) {
        return
    }
    let arrb: Array<Byte> = [6, 5, 4, 3, 5, 16, 7]
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    a_buffer.indexOf(int8)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.indexOf")
    unsafe {
        DT_FUZZ_Int8(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
