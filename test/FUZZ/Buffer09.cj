// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
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
