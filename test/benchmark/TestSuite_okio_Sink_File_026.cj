// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*

func runBench(n:Int64):Unit{
	var file : File = File.create("okio_Sink_File_026.txt")
	let s = MonoTime.now()
	for (i in 0..n){
		Okio.sink(file)
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_Sink_File_026_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
	remove("okio_Sink_File_026.txt")
}

main(){
	println("TCS: okio_Sink_File_026, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	for (n in count){
		runBench(n)
	}
}
