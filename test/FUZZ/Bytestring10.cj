// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(int64: Int64) {
    var byteString = ByteString("hello world".toUtf8Array())
    var byteString2 = ByteString("l".toUtf8Array())
    var idx = byteString.lastIndexOf(byteString2, int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_byteString.lastIndexOf")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
