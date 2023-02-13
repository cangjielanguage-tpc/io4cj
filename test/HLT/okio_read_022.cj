// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_read_022{

    @TestCase
    func okio_read_022(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        a_buffer.write(arrb)
        @Assert(a_buffer.read(arrb2,5,1),1)
        println(arrb2)
        println(a_buffer.size)
        println(a_buffer.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 0, 0, 6, 0]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,6)
        @Assert(a_buffer.exhausted(),false)
    }
    @TestCase
    func okio_read_022_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        a_buffer.write(arrb)
        @Assert(bufferedSource.read(arrb2,5,1),1)
        println(arrb2)
        println(bufferedSource.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 0, 0, 6, 0]
        @Assert(arrb2,arrb3)
        @Assert(bufferedSource.exhausted(),false)
    }
}