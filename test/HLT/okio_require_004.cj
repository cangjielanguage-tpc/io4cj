// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_require_004{

    @TestCase //require(byteCount: Int64): Unit byteCount >BufferedSource长度 异常
    func okio_require_004(): Unit {
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.require(8))
        } catch(e: okio.EOFException) { 
            //println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"Exception")
    }
    @TestCase //require(byteCount: Int64): Unit byteCount >BufferedSource长度 异常
    func okio_require_004_2(): Unit {
        // println("---------------------------------------------------------------")
        var exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            a_buffer2.write(arrb)
            println(bufferedSource.require(8))
        } catch(e: okio.EOFException) { 
            // println(e.printStackTrace())
            exc = "Exception"
        }
        @Assert(exc,"Exception")
        
        exc = ""
        try{
            let arrb:Array<Byte> = [6,5,4,3,2,16,7]
            let a_buffer2 = Buffer()
            let source: Source = a_buffer2
            let bufferedSource: BufferedSource = Okio.buffer(source)
            bufferedSource.close()  
            bufferedSource.require(8)
        } catch (e:IllegalArgumentException) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"closed")
    }
}