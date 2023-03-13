// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {
    let data: Buffer = Buffer()
    let testString: String = "123456789"
    data.writeUtf8(testString)
    let sink: Buffer = Buffer()
    let gs: GzipSink = GzipSink(sink)
    gs.write(data, int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_gs.write")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
