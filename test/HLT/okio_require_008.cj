// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_require_008{

    @TestCase //require(byteCount: Int64): Unit  byteCount = -1 异常
    func okio_require_008(): Unit {
        var exc = ""
        try{
            let a_buffer = Buffer()
            // a_buffer.write(arrb)
            println(a_buffer.require(-1))
        } catch(e: Exception) { //EOFException 不是public
            println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase //require(byteCount: Int64): Unit  byteCount = -1 异常
    func okio_require_008_2(): Unit {
        var exc = ""
        try{
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            // a_buffer.write(arrb)
            println(bufferedSource.require(-1))
        } catch(e: Exception) { //EOFException 不是public
            // println(e.printStackTrace())
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"byteCount <0: -1")
    }
}