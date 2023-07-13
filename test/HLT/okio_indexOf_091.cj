// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_091{

    @TestCase
    func okio_indexOf_091(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            println(a_buffer.indexOf(0,1,0))
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("fromIndex: 1 is greater than toIndex: 1 or less than 0"),true)
    } 
    @TestCase
    func okio_indexOf_091_2(): Unit {
        var exc = ""
        try {
            let arrb:Array<Byte> = [6,0,4,3,5,16,5]
            let a_buffer = Buffer()
            a_buffer.write(arrb)
            let source: Source = a_buffer
            let bufferedSource: BufferedSource = Okio.buffer(source)
            println(bufferedSource.indexOf(0,1,0))
        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc=e.message
        }
        @Assert(exc.contains("fromIndex=1 toIndex=0"),true)
    } 
}