// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_readFully_055{

    @TestCase
    func okio_readFully_055(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let a_buffer2 = Buffer()
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        a_buffer.readFully(a_buffer2,9)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer3 = Buffer()
        a_buffer3.write(arrb)
        // @Assert(a_buffer3,a_buffer2)
        println(a_buffer3.toString())
        println(a_buffer2.toString())
        @Assert(a_buffer2.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(a_buffer.size,0)
        @Assert(a_buffer.exhausted(),true)
    }
    @TestCase
    func okio_readFully_055_2(): Unit {
        let arrb:Array<Byte> = [6,5,4,3,2,16,7,100,9]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let a_buffer2 = Buffer()
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(a_buffer.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        bufferedSource.readFully(a_buffer2,9)
        let arrb3:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer3 = Buffer()
        a_buffer3.write(arrb)
        // @Assert(a_buffer3,a_buffer2)
        println(a_buffer3.toString())
        println(a_buffer2.toString())
        @Assert(a_buffer2.toString(),"[size=9] [6, 5, 4, 3, 2, 16, 7, 100, 9]")
        @Assert(bufferedSource.exhausted(),true)
    }
}