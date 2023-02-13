// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt8_029{

    @TestCase
    func okio_readInt8_029(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.toString(),"[size=7] [6, 5, 4, 3, 2, 16, 7]")
        @Assert(a_buffer.readInt8(),6)
        @Assert(a_buffer.toString(),"[size=6] [5, 4, 3, 2, 16, 7]")
        @Assert(a_buffer.size,6)
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_readInt8_029_2(): Unit {
        // println("---------------------------------------------------------------")
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readInt8(),6)
        @Assert(bufferedSource.exhausted(),false)
        
        var exc = ""
        try{
            bufferedSource.close()
            bufferedSource.readInt8()
        } catch (e:Exception){
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc,"closed")
    }
}