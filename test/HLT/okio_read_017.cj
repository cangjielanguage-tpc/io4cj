// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_017{

    @TestCase
    func okio_read_017(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(8,item:0)
        @Assert(a_buffer.read(arrb2),Int64(7))
        println(arrb2)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7,0]
        @Assert(arrb2,arrb3)
        println(a_buffer.size)
        @Assert(a_buffer.size,0)
        println(a_buffer.exhausted())
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_read_017_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(8,item:0)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)

        @Assert(bufferedSource.read(arrb2),Int64(7))
        println(arrb2)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7,0]
        @Assert(arrb2,arrb3)
        println(bufferedSource.exhausted())
        @Assert(bufferedSource.exhausted(),true)
    }
}