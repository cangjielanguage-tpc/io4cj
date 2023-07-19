// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_028{

    @TestCase
    func okio_read_028(): Unit {

        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        @Assert(a_buffer.read(arrb2,3,2),2)
        println(arrb2)
        println(a_buffer.size)
        println(a_buffer.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 6,5,0,0]
        @Assert(arrb2,arrb3)
        @Assert(a_buffer.size,5)
        @Assert(a_buffer.exhausted(),false)

    }
    @TestCase
    func okio_read_028_2(): Unit {
        println("---------------------------------------------------------------")
        let arrb:Array<Byte> = [6,5,4,3,2,16,7]
        let a_buffer = Buffer()
        a_buffer.write(arrb)
        let arrb2 :Array<Byte> = Array<Byte>(7,item:0)
        let source: Source = a_buffer
        let bufferedSource: BufferedSource = Okio.buffer(source)
        @Assert(bufferedSource.read(arrb2,3,2),2)
        println(arrb2)
        println(bufferedSource.exhausted())
        let arrb3 :Array<Byte> = [0, 0, 0, 6,5,0,0]
        @Assert(arrb2,arrb3)
        @Assert(bufferedSource.exhausted(),false)

    }
}