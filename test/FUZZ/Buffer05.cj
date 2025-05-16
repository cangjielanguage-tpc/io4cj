// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
func call_fuzz(int64: Int64) {
    if (int64 < 0 || int64 > 5) {
        return
    }
    let arrb: Array<Byte> = [6, 5, 4, 3, 2, 16, 7]
    let a_buffer = Buffer()
    a_buffer.write(arrb)
    let arrb2: Array<Byte> = Array<Byte>(7, repeat: 0)
    a_buffer.read(arrb2, int64, 2)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_a_buffer.read")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
