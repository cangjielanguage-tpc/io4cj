// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import std.fs.*
import io4cj.*
import std.collection.*

func runBench(n:Int64, dataLen:Int64):Unit{
	var data = StringBuilder( r'X',dataLen).toString()
	let arr = data.toArray()
	let s = MonoTime.now()
	for (i in 0..n){
		ByteString.of(arr)
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_of_028_${dataLen}_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
}

main(){
	println("TCS: okio_of_028, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	let dataLens = [10, 100, 1000, 10000, 100000]  
	for (dataLen in dataLens){
		for (n in count){
			runBench(n, dataLen)
		}
	}
} 
