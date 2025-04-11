// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import io4cj.*
func runBench(n:Int64):Unit{
	let bufferedSink:BufferedSink = Buffer()
	let s = MonoTime.now()
	for (i in 0..n){
		bufferedSink.writeInt32(16909320)
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_writeInt32_006_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
}

main(){
	println("TCS: okio_writeInt32_006, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	for (n in count){
		runBench(n)
	}
}
