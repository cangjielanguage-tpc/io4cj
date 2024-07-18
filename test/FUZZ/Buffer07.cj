// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(int8: Int8) {
    if (int64 < 0) {
        return
    }
    let arrb: Array<Byte> = [6, 5, 4, 3, 5, 16, 7]
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    a_buffer.indexOf(int8)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.indexOf")
    unsafe {
        DT_FUZZ_Int8(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
