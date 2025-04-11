// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

import std.io.*
import std.time.*
import io4cj.*
import std.collection.*

func runBench(n:Int64, dataLen:Int64):Unit{
	var data = StringBuilder( r'1',dataLen).toString()
	var buffer = Buffer()
    let source: Source = buffer
    let bufferedSource: BufferedSource = Okio.buffer(source)
	buffer.writeUtf8(data)

	let s = MonoTime.now()
	for (i in 0..n){
		bufferedSource.getBuffer()
	}
	let tmp = MonoTime.now()
	let e=(tmp-s).toNanoseconds()
	print("[ PASSED ] CASE: okio_getBuffer_007_${dataLen}_${n} (${e} ns, ${Float64(e)/Float64(n)} ns/op)\n", flush:true)
}

main(){
	println("TCS: okio_getBuffer_007, time elapsed: 1 ns, RESULT:")
	let count = [10, 100, 1000, 10000, 100000]  
	let dataLens = [10, 100, 1000, 10000, 100000]  
	for (dataLen in dataLens){
		for (n in count){
			runBench(n, dataLen)
		}
	}
}
