// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {
    if (int64 < 0 || int64 > 5) {
        return
    }
    let arrb: Array<Byte> = [6, 5, 4, 3, 2, 16, 7]
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    let arrb2: Array<Byte> = Array<Byte>(7, item: 0)
    a_buffer.read(arrb2, int64, 2)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.read")
    unsafe {
        DT_FUZZ_Int64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
