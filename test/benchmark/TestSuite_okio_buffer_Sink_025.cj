// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import io4cj.*


func runBench(n:Int64):Unit{
	let sink:Sink = Buffer()
	let s = MonoTime.now()
	for (i in 0..n){
		Okio.buffer(sink)
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_buffer_Sink_025_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
}

main(){
	println("TCS: okio_buffer_Sink_025, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	for (n in count){
		runBench(n)
	}
}
