// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_require_005{

    @TestCase //require(byteCount: Int64): Unit byteCount = BufferedSource长度 没有处理 不抛异常
    func okio_require_005(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.require(7))
        } catch(e: Exception) {
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
    @TestCase //require(byteCount: Int64): Unit byteCount = BufferedSource长度 没有处理 不抛异常
    func okio_require_005_2(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            a_buffer2.write(arrb)
            println(bufferedSource.require(7))
        } catch(e: Exception) {
            println("Exception")
            exc = "Exception"
        }
        @Assert(exc,"")
    }
}