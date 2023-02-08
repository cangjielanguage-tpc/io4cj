// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
from std import io.*
from std import time.*
from okio import okio.*

func call_fuzz(int64: InT64) {
    let data: Buffer = Buffer()
    let testString: String = "It's a UNIX system! I know this!"
    data.writeUtf8(testString)
    let sink: Buffer = Buffer()
    let result: Buffer = Buffer()
    let gs: GzipSink = GzipSink(sink)
    gs.write(data, data.size)
    gs.close()
    let result1: Buffer = Buffer()
    let source: GzipSource = GzipSource(sink)
    while (source.read(result1, int64) != -1) {}
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_source.read")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
