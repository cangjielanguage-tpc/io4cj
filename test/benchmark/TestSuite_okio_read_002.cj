// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import io4cj.*
import std.collection.*

func runBench(n:Int64,dataLen:Int64):Unit{
	let arrb=Array<Byte>(dataLen, repeat: 1)
	let sink = Buffer()
	let source = Buffer()
	source.write(arrb)
	let s = MonoTime.now()
	for (i in 0..n){
       source.read(sink,3)
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_read_002_${dataLen}_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
}

main(){
	println("TCS: okio_read_002, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	let dataLens = [10, 100, 1000, 10000, 100000]  

	for (dataLen in dataLens){
		for (n in count){
			runBench(n, dataLen)
		}
	}
}

