// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_skip_093{

    @TestCase
    func okio_skip_093(): Unit {
        let arrb:Array<Byte> = [6,0,4,3,5,16,5]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        println(a_buffer)
        @Assert(a_buffer.toString(),"[size=7] [6, 0, 4, 3, 5, 16, 5]")
        println(a_buffer.skip(1))
        println(a_buffer)
        @Assert(a_buffer.toString(),"[size=6] [0, 4, 3, 5, 16, 5]")
    }
    @TestCase
    func okio_skip_093_2(): Unit {
        let arrb:Array<Byte> = [6,0,4,3,5,16,5]
        let arrb2:Array<Byte> = Array<Byte>(7,item:0)
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        
        println(bufferedSource.request(1))
        println(bufferedSource)
        @Assert(bufferedSource.toString(),"RealBufferedSource: [size=7] [6, 0, 4, 3, 5, 16, 5]")
        println(bufferedSource.skip(1))
        println(bufferedSource)
        @Assert(bufferedSource.toString(),"RealBufferedSource: [size=6] [0, 4, 3, 5, 16, 5]")
    
        var exc = ""
        try{
            bufferedSource.close()
            bufferedSource.skip(1)
        } catch (e:Exception) {
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc.contains("closed"),true)
    
    }
}