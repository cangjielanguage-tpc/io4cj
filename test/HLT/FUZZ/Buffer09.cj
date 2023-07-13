// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {
    if (int64 < 0 || int64 > 4) {
        return
    }
    let arrb: Array<Byte> = [6, 5, 4, 3]
    let sink = Buffer()
    let source = Buffer()
    source.write(arrb)
    sink.write(source, int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_sink.write")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
