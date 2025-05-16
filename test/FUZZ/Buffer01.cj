// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi
import std.io.*
import std.time.*
import io4cj.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList

func call_fuzz(int641: Int64, int642: Int64) {
    var buffer = Buffer()
    buffer.write([6, 5, 4, 3, 2, 16, 7]).writeUtf8("华为").writeUtf8("中国")
	if (int641<0 || int642 <0 || int641>buffer.size || int641+int642>=buffer.size){
	return
	}
    var buffer2 = Buffer()
    buffer.copyTo(buffer2, int641, int642)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_buffer.copyTo")
    unsafe {
        DT_FUZZ_Int64_2(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
