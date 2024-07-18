// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(string: String) {
    let bufferedSink = Buffer()
    bufferedSink.writeUtf8(string)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_bufferedSink.writeUtf8")
    unsafe {
        DT_FUZZ_String(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
