// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(int64: Int64) {

    if (int64 > 130000000 || int64< 1 ) {
        return
    }
    let data: Buffer = Buffer()
    let testString: String = "123456789"
    data.writeUtf8(testString)
    let sink: Buffer = Buffer()
    let gs: GzipSink = GzipSink(sink)
    gs.write(data, int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_gs.write")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
