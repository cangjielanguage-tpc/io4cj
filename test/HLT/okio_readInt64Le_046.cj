// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readInt64Le_046{

    @TestCase
    func okio_readInt64Le_046(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,9,11]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        @Assert(a_buffer.readInt64Le(),Int64(9<<8<<8<<8<<8<<8<<8<<8 | 7<<8<<8<<8<<8<<8<<8 | 16<<8<<8<<8<<8<<8 | 2<<8<<8<<8<<8 | 3<<8<<8<<8 | 4<<8<<8 | 5<<8 | 6))
        @Assert(a_buffer.size,1)
        @Assert(a_buffer.exhausted(),false)

    }
    @TestCase
    func okio_readInt64Le_046_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,9,11]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.readInt64Le(),Int64(9<<8<<8<<8<<8<<8<<8<<8 | 7<<8<<8<<8<<8<<8<<8 | 16<<8<<8<<8<<8<<8 | 2<<8<<8<<8<<8 | 3<<8<<8<<8 | 4<<8<<8 | 5<<8 | 6))
        @Assert(bufferedSource.exhausted(),false)

        var exc = ""
        try{
            bufferedSource.close()
            bufferedSource.readInt64Le()
        } catch (e:Exception){
            exc = e.message
            println("e.message : ${e.message}")
        }
        @Assert(exc,"closed")
    }
}