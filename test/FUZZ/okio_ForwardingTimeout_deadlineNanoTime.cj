// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(int64: Int64) {
    let str = Timeout()
    let str2 = str.deadlineNanoTime(int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_str.deadlineNanoTime")
    unsafe {
        DT_FUZZ_InT64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
