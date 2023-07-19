// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj
from std import io.*
from std import time.*
from io4cj import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {

    if (int64< 0 ) {
        return
    }
    let inflated: Buffer = Buffer()
    let aaa: Array<UInt8> = [243, 44, 81, 47, 86, 72, 84]
    let ssss: Buffer = Buffer()
    ssss.write(aaa)
    let source: InflaterSource = InflaterSource(ssss)
    var source1 = source.read(inflated, int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_source.read")
    unsafe {
        DT_FUZZ_Int64(0,30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
